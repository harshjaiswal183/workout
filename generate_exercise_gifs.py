#!/usr/bin/env python3
"""
Generates cartoon stick-figure exercise animations for all workout exercises.
Run: python3 generate_exercise_gifs.py
Requires: pip install Pillow
"""

from PIL import Image, ImageDraw
import math
import os

OUT = '/Users/harshjaiswal/Desktop/flutter project/workout/assets/gifs'
os.makedirs(OUT, exist_ok=True)

W, H = 300, 300

# ── Color palette ──────────────────────────────────────────────────────────
BG_TOP   = (14, 20, 52)
BG_BOT   = (26, 44, 92)
GND_C    = (55, 200, 120)
BODY_C   = (65, 205, 252)
HEAD_C   = (255, 215, 72)
JNT_C    = (255, 108, 52)
SHADOW_C = (8,  12,  35)
WALL_C   = (80, 80, 120)
LW = 5;  JR = 5;  HR = 15

# ── Drawing helpers ─────────────────────────────────────────────────────────
def draw_bg(d, ground=True, wall=False):
    for y in range(H):
        t = y / H
        r = int(BG_TOP[0] * (1-t) + BG_BOT[0] * t)
        g = int(BG_TOP[1] * (1-t) + BG_BOT[1] * t)
        b = int(BG_TOP[2] * (1-t) + BG_BOT[2] * t)
        d.line([(0, y), (W, y)], fill=(r, g, b))
    if ground:
        d.ellipse([(105, 272), (195, 282)], fill=SHADOW_C)
        d.line([(0, 274), (W, 274)], fill=GND_C, width=3)
    if wall:
        d.rectangle([(220, 60), (240, 274)], fill=WALL_C)
        d.line([(220, 60), (220, 274)], fill=(100, 100, 150), width=2)

def draw_bg_ground(d, gy=245):
    for y in range(H):
        t = y / H
        r = int(BG_TOP[0] * (1-t) + BG_BOT[0] * t)
        g = int(BG_TOP[1] * (1-t) + BG_BOT[1] * t)
        b = int(BG_TOP[2] * (1-t) + BG_BOT[2] * t)
        d.line([(0, y), (W, y)], fill=(r, g, b))
    d.line([(0, gy), (W, gy)], fill=GND_C, width=3)

def draw_head(d, x, y, r=HR):
    x, y = int(x), int(y)
    d.ellipse([(x-r, y-r), (x+r, y+r)], fill=HEAD_C, outline=BODY_C, width=2)
    d.ellipse([(x-7, y-5), (x-3, y-1)], fill=BG_TOP)
    d.ellipse([(x+3, y-5), (x+7, y-1)], fill=BG_TOP)
    d.arc([(x-5, y+2), (x+5, y+8)], 0, 180, fill=BG_TOP, width=2)

def draw_joint(d, p, r=JR):
    x, y = int(p[0]), int(p[1])
    d.ellipse([(x-r, y-r), (x+r, y+r)], fill=JNT_C)

def ln(d, p1, p2, c=BODY_C, w=LW):
    d.line([(int(p1[0]), int(p1[1])), (int(p2[0]), int(p2[1]))], fill=c, width=w)

def lerp(a, b, t):
    if isinstance(a, (tuple, list)):
        return tuple(a[i] + (b[i] - a[i]) * t for i in range(len(a)))
    return a + (b - a) * t

def lp(pa, pb, t):
    return {k: lerp(pa[k], pb[k], t) for k in pa if k in pb}

def make_frames(keyframes, n=6):
    out = []
    for i in range(len(keyframes)):
        a = keyframes[i]
        b = keyframes[(i + 1) % len(keyframes)]
        for j in range(n):
            out.append(lp(a, b, j / n))
    return out

CONN_STD = [
    ('neck', 'shl'), ('neck', 'shr'),
    ('shl', 'ell'), ('ell', 'hdl'),
    ('shr', 'elr'), ('elr', 'hdr'),
    ('neck', 'hip'),
    ('hip', 'knl'), ('hip', 'knr'),
    ('knl', 'ftl'), ('knr', 'ftr'),
]

def render_frame(pose, ground=True, wall=False, extra_conn=None, extra_fn=None, gy=None):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    if gy is not None:
        draw_bg_ground(d, gy)
    else:
        draw_bg(d, ground, wall)
    conn = CONN_STD + (extra_conn or [])
    for (a, b) in conn:
        if a in pose and b in pose:
            ln(d, pose[a], pose[b])
    for k in ['neck', 'shl', 'shr', 'ell', 'elr', 'hdl', 'hdr', 'hip', 'knl', 'knr']:
        if k in pose:
            draw_joint(d, pose[k])
    if 'hd' in pose:
        hx, hy = pose['hd']
        draw_head(d, hx, hy)
    if extra_fn:
        extra_fn(d)
    return img

def save_gif(frames_data, name, dur=100, **kw):
    imgs = [render_frame(f, **kw) for f in frames_data]
    path = os.path.join(OUT, name)
    imgs[0].save(path, save_all=True, append_images=imgs[1:],
                 optimize=False, duration=dur, loop=0)
    print(f"✓  {name}")

# ═══════════════════════════════════════════════════════════════════════════
# POSE TEMPLATES
# ═══════════════════════════════════════════════════════════════════════════

# ── FRONT VIEW STANDING ──
STAND = {
    'hd':   (150, 47), 'neck': (150, 66),
    'shl':  (124, 83), 'shr':  (176, 83),
    'ell':  (108, 122), 'elr':  (192, 122),
    'hdl':  (102, 157), 'hdr':  (198, 157),
    'hip':  (150, 163),
    'knl':  (136, 213), 'knr':  (164, 213),
    'ftl':  (130, 263), 'ftr':  (170, 263),
}

# ── SQUAT BOTTOM ──
SQUAT_BOT = {
    'hd':   (150, 80), 'neck': (150, 99),
    'shl':  (124, 115), 'shr':  (176, 115),
    'ell':  (110, 143), 'elr':  (190, 143),
    'hdl':  (105, 167), 'hdr':  (195, 167),
    'hip':  (150, 185),
    'knl':  (118, 220), 'knr':  (182, 220),
    'ftl':  (108, 265), 'ftr':  (192, 265),
}

# ── SIDE VIEW STANDING ──
STAND_S = {
    'hd':   (160, 47), 'neck': (158, 66),
    'shl':  (150, 83), 'shr':  (167, 83),
    'ell':  (144, 122), 'elr':  (170, 122),
    'hdl':  (140, 157), 'hdr':  (173, 157),
    'hip':  (155, 163),
    'knl':  (150, 213), 'knr':  (160, 213),
    'ftl':  (145, 263), 'ftr':  (165, 263),
}

# ── PRONE (face-down, side view, head right) ──
PRONE = {
    'hd':   (258, 198), 'neck': (238, 200),
    'shl':  (218, 200), 'shr':  (222, 207),
    'ell':  (210, 210), 'elr':  (213, 216),
    'hdl':  (196, 226), 'hdr':  (198, 232),
    'hip':  (172, 200),
    'knl':  (124, 202), 'knr':  (127, 208),
    'ftl':  (72,  204), 'ftr':  (75,  210),
}

# ── SUPINE (face-up, lying, head left) ──
SUPINE = {
    'hd':   (55,  212), 'neck': (73,  213),
    'shl':  (92,  210), 'shr':  (96,  218),
    'ell':  (112, 210), 'elr':  (115, 218),
    'hdl':  (130, 210), 'hdr':  (132, 218),
    'hip':  (168, 212),
    'knl':  (205, 215), 'knr':  (208, 222),
    'ftl':  (245, 218), 'ftr':  (248, 225),
}

# ── ALL FOURS (side view) ──
ALLFOURS = {
    'hd':   (248, 172), 'neck': (228, 180),
    'shl':  (210, 186), 'shr':  (214, 194),
    'ell':  (208, 217), 'elr':  (211, 224),
    'hdl':  (207, 248), 'hdr':  (210, 254),
    'hip':  (152, 182),
    'knl':  (148, 218), 'knr':  (151, 225),
    'ftl':  (147, 248), 'ftr':  (150, 254),
}

# ═══════════════════════════════════════════════════════════════════════════
# GENERATE ALL GIFs
# ═══════════════════════════════════════════════════════════════════════════

print("=== Generating Exercise GIFs ===\n")

# ──────────────────────────────────────────────────────────────────────────
# CHEST EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# wide_pushup.gif  (prone, arms wide)
wp_up = {
    'hd': (255, 195), 'neck': (235, 198),
    'shl': (210, 195), 'shr': (215, 204),
    'ell': (188, 195), 'elr': (193, 207),
    'hdl': (165, 225), 'hdr': (168, 238),
    'hip': (168, 200), 'knl': (120, 202), 'knr': (123, 208),
    'ftl': (68, 205), 'ftr': (71, 211),
}
wp_dn = {
    'hd': (252, 218), 'neck': (234, 216),
    'shl': (210, 210), 'shr': (215, 218),
    'ell': (190, 224), 'elr': (195, 232),
    'hdl': (168, 245), 'hdr': (170, 252),
    'hip': (168, 210), 'knl': (120, 212), 'knr': (123, 218),
    'ftl': (68, 215), 'ftr': (71, 222),
}
save_gif(make_frames([wp_up, wp_dn], 8), 'wide_pushup.gif', ground=False, gy=268)

# diamond_pushup.gif  (prone, hands close)
dp_up = {
    'hd': (255, 193), 'neck': (235, 196),
    'shl': (212, 196), 'shr': (218, 204),
    'ell': (205, 207), 'elr': (209, 214),
    'hdl': (196, 225), 'hdr': (199, 230),
    'hip': (168, 198), 'knl': (120, 200), 'knr': (123, 206),
    'ftl': (68, 203), 'ftr': (71, 209),
}
dp_dn = {
    'hd': (252, 218), 'neck': (233, 218),
    'shl': (213, 215), 'shr': (218, 222),
    'ell': (207, 228), 'elr': (210, 235),
    'hdl': (199, 248), 'hdr': (202, 254),
    'hip': (168, 210), 'knl': (120, 212), 'knr': (123, 218),
    'ftl': (68, 215), 'ftr': (71, 222),
}
save_gif(make_frames([dp_up, dp_dn], 8), 'diamond_pushup.gif', ground=False, gy=268)

# incline_pushup.gif  (hands elevated on a surface)
def draw_bench(d):
    d.rectangle([(80, 155), (175, 175)], fill=(90, 65, 45))
    d.rectangle([(80, 145), (175, 158)], fill=(110, 80, 55))

ip_up = {
    'hd': (242, 112), 'neck': (225, 122),
    'shl': (207, 130), 'shr': (212, 138),
    'ell': (198, 150), 'elr': (202, 158),
    'hdl': (170, 162), 'hdr': (172, 168),
    'hip': (168, 158), 'knl': (120, 185), 'knr': (123, 192),
    'ftl': (68, 222), 'ftr': (71, 228),
}
ip_dn = {
    'hd': (238, 130), 'neck': (222, 136),
    'shl': (207, 140), 'shr': (212, 148),
    'ell': (200, 158), 'elr': (204, 166),
    'hdl': (172, 162), 'hdr': (175, 168),
    'hip': (168, 165), 'knl': (120, 192), 'knr': (123, 198),
    'ftl': (68, 228), 'ftr': (71, 234),
}
def render_incline(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d)
    draw_bench(d)
    conn = CONN_STD
    for (a, b) in conn:
        if a in pose and b in pose:
            ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose:
        draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

frames_ip = [render_incline(lp(ip_up, ip_dn, j/8)) for j in range(8)] + \
            [render_incline(lp(ip_dn, ip_up, j/8)) for j in range(8)]
frames_ip[0].save(os.path.join(OUT, 'incline_pushup.gif'), save_all=True,
    append_images=frames_ip[1:], optimize=False, duration=100, loop=0)
print("✓  incline_pushup.gif")

# decline_pushup.gif  (feet elevated)
def draw_box(d):
    d.rectangle([(50, 230), (120, 268)], fill=(90, 65, 45))
    d.rectangle([(50, 220), (120, 233)], fill=(110, 80, 55))

dec_up = {
    'hd': (255, 145), 'neck': (237, 152),
    'shl': (217, 158), 'shr': (222, 165),
    'ell': (205, 172), 'elr': (208, 180),
    'hdl': (190, 205), 'hdr': (193, 212),
    'hip': (163, 175), 'knl': (105, 193), 'knr': (108, 200),
    'ftl': (72, 228), 'ftr': (75, 234),
}
dec_dn = {
    'hd': (250, 164), 'neck': (233, 168),
    'shl': (217, 170), 'shr': (222, 178),
    'ell': (207, 185), 'elr': (210, 192),
    'hdl': (193, 210), 'hdr': (196, 217),
    'hip': (163, 180), 'knl': (105, 198), 'knr': (108, 204),
    'ftl': (72, 228), 'ftr': (75, 234),
}
def render_decline(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d)
    draw_box(d)
    for (a, b) in CONN_STD:
        if a in pose and b in pose: ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose: draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

frames_dec = [render_decline(lp(dec_up, dec_dn, j/8)) for j in range(8)] + \
             [render_decline(lp(dec_dn, dec_up, j/8)) for j in range(8)]
frames_dec[0].save(os.path.join(OUT, 'decline_pushup.gif'), save_all=True,
    append_images=frames_dec[1:], optimize=False, duration=100, loop=0)
print("✓  decline_pushup.gif")

# chest_squeeze.gif  (standing, palms pressed)
cs1 = {**STAND, 'ell': (130, 132), 'elr': (170, 132), 'hdl': (145, 155), 'hdr': (155, 155)}
cs2 = {**STAND, 'ell': (132, 132), 'elr': (168, 132), 'hdl': (147, 152), 'hdr': (153, 152)}
save_gif(make_frames([cs1, cs2], 8), 'chest_squeeze.gif')

# ──────────────────────────────────────────────────────────────────────────
# BACK EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# superman.gif  (prone, arms & legs lift)
sup_dn = {**PRONE}
sup_up = {
    'hd': (255, 188), 'neck': (236, 192),
    'shl': (216, 193), 'shr': (220, 200),
    'ell': (195, 190), 'elr': (198, 197),
    'hdl': (168, 185), 'hdr': (172, 192),
    'hip': (172, 198),
    'knl': (126, 196), 'knr': (130, 203),
    'ftl': (75, 192), 'ftr': (78, 198),
}
save_gif(make_frames([sup_dn, sup_up], 8), 'superman.gif', ground=False, gy=268)

# cobra.gif  (prone, chest lifts)
cob_dn = {**PRONE}
cob_up = {
    'hd': (255, 162), 'neck': (238, 173),
    'shl': (218, 185), 'shr': (222, 192),
    'ell': (210, 208), 'elr': (214, 215),
    'hdl': (198, 232), 'hdr': (200, 238),
    'hip': (170, 200), 'knl': (122, 202), 'knr': (125, 208),
    'ftl': (70, 205), 'ftr': (73, 211),
}
save_gif(make_frames([cob_dn, cob_up, cob_up, cob_dn], 6), 'cobra.gif', ground=False, gy=268)

# reverse_snow_angel.gif (prone, arms sweep forward)
rsa1 = {  # arms at sides
    'hd': PRONE['hd'], 'neck': PRONE['neck'],
    'shl': (218, 200), 'shr': (222, 207),
    'ell': (185, 208), 'elr': (188, 215),
    'hdl': (148, 215), 'hdr': (152, 222),
    'hip': PRONE['hip'], 'knl': PRONE['knl'], 'knr': PRONE['knr'],
    'ftl': PRONE['ftl'], 'ftr': PRONE['ftr'],
}
rsa2 = {  # arms extended forward
    'hd': PRONE['hd'], 'neck': PRONE['neck'],
    'shl': (218, 196), 'shr': (222, 203),
    'ell': (205, 192), 'elr': (208, 198),
    'hdl': (190, 188), 'hdr': (193, 194),
    'hip': PRONE['hip'], 'knl': PRONE['knl'], 'knr': PRONE['knr'],
    'ftl': PRONE['ftl'], 'ftr': PRONE['ftr'],
}
save_gif(make_frames([rsa1, rsa2], 8), 'reverse_snow_angel.gif', ground=False, gy=268)

# bird_dog.gif  (all fours, opp arm/leg extend)
bd1 = {**ALLFOURS}
bd2 = {
    'hd': (248, 172), 'neck': (228, 180),
    'shl': (210, 186), 'shr': (214, 194),
    'ell': (195, 180), 'elr': (211, 224),   # left arm extended
    'hdl': (175, 174), 'hdr': (210, 254),
    'hip': (152, 182),
    'knl': (148, 218), 'knr': (158, 222),   # right leg extended back
    'ftl': (147, 248), 'ftr': (172, 238),
}
save_gif(make_frames([bd1, bd2, bd2, bd1], 6), 'bird_dog.gif', ground=False, gy=268)

# prone_y_raise.gif  (prone, Y arms)
py1 = {**PRONE}
py2 = {
    'hd': (255, 196), 'neck': (237, 198),
    'shl': (218, 198), 'shr': (222, 205),
    'ell': (202, 193), 'elr': (207, 200),
    'hdl': (185, 188), 'hdr': (190, 195),
    'hip': (172, 200), 'knl': (124, 202), 'knr': (127, 208),
    'ftl': (72, 205), 'ftr': (75, 211),
}
save_gif(make_frames([py1, py2, py2, py1], 6), 'prone_y_raise.gif', ground=False, gy=268)

# prone_w_extension.gif  (prone, W arms)
pw1 = {**PRONE}
pw2 = {
    'hd': (255, 197), 'neck': (237, 199),
    'shl': (218, 198), 'shr': (222, 205),
    'ell': (205, 194), 'elr': (210, 201),
    'hdl': (218, 188), 'hdr': (222, 195),
    'hip': (172, 200), 'knl': (124, 202), 'knr': (127, 208),
    'ftl': (72, 205), 'ftr': (75, 211),
}
save_gif(make_frames([pw1, pw2, pw2, pw1], 6), 'prone_w_extension.gif', ground=False, gy=268)

# ──────────────────────────────────────────────────────────────────────────
# LEGS EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# squat.gif
save_gif(make_frames([STAND, SQUAT_BOT], 8), 'squat.gif')

# sumo_squat.gif  (wider stance)
sumo_top = {**STAND, 'ftl': (110, 263), 'ftr': (190, 263),
            'knl': (118, 213), 'knr': (182, 213)}
sumo_bot = {
    'hd': (150, 88), 'neck': (150, 107),
    'shl': (124, 123), 'shr': (176, 123),
    'ell': (108, 150), 'elr': (192, 150),
    'hdl': (105, 175), 'hdr': (195, 175),
    'hip': (150, 192),
    'knl': (108, 228), 'knr': (192, 228),
    'ftl': (95, 265), 'ftr': (205, 265),
}
save_gif(make_frames([sumo_top, sumo_bot], 8), 'sumo_squat.gif')

# lunge.gif  (forward step)
lng1 = {**STAND}
lng2 = {
    'hd': (150, 58), 'neck': (150, 77),
    'shl': (130, 93), 'shr': (170, 93),
    'ell': (118, 130), 'elr': (182, 130),
    'hdl': (113, 162), 'hdr': (187, 162),
    'hip': (148, 170),
    'knl': (175, 215), 'knr': (118, 248),
    'ftl': (182, 265), 'ftr': (105, 265),
}
save_gif(make_frames([lng1, lng2], 8), 'lunge.gif')

# reverse_lunge.gif  (step back)
rl1 = {**STAND}
rl2 = {
    'hd': (150, 58), 'neck': (150, 77),
    'shl': (130, 93), 'shr': (170, 93),
    'ell': (118, 130), 'elr': (182, 130),
    'hdl': (113, 162), 'hdr': (187, 162),
    'hip': (148, 170),
    'knl': (138, 215), 'knr': (125, 248),
    'ftl': (142, 265), 'ftr': (112, 265),
}
save_gif(make_frames([rl1, rl2], 8), 'reverse_lunge.gif')

# glute_bridge.gif  (supine, hips lift)
gb_dn = {**SUPINE}
gb_up = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (112, 218), 'elr': (115, 226),
    'hdl': (130, 225), 'hdr': (132, 233),
    'hip': (168, 182),
    'knl': (195, 210), 'knr': (198, 218),
    'ftl': (228, 235), 'ftr': (232, 242),
}
save_gif(make_frames([gb_dn, gb_up], 8), 'glute_bridge.gif', ground=False, gy=255)

# calf_raise.gif  (toes rise)
cr1 = {**STAND}
cr2 = {**STAND,
    'knl': (136, 208), 'knr': (164, 208),
    'ftl': (133, 248), 'ftr': (167, 248),
    'hd':  (150, 38), 'neck': (150, 57),
    'shl': (124, 74), 'shr': (176, 74),
    'ell': (108, 113), 'elr': (192, 113),
    'hdl': (102, 148), 'hdr': (198, 148),
    'hip': (150, 154),
}
save_gif(make_frames([cr1, cr2, cr2, cr1], 5), 'calf_raise.gif')

# wall_sit.gif  (seated at wall)
def draw_wall_rect(d):
    d.rectangle([(200, 50), (225, 274)], fill=WALL_C)

ws_pose = {
    'hd': (150, 75), 'neck': (155, 93),
    'shl': (135, 107), 'shr': (178, 107),
    'ell': (122, 145), 'elr': (190, 145),
    'hdl': (118, 180), 'hdr': (195, 180),
    'hip': (152, 185),
    'knl': (118, 220), 'knr': (182, 220),
    'ftl': (115, 265), 'ftr': (180, 265),
}
ws_pose2 = {**ws_pose, 'hd': (151, 76)}  # slight bounce for animation

def render_wall_sit(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d)
    draw_wall_rect(d)
    for (a, b) in CONN_STD:
        if a in pose and b in pose: ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose: draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

wf = [render_wall_sit(lp(ws_pose, ws_pose2, j/6)) for j in range(6)] + \
     [render_wall_sit(lp(ws_pose2, ws_pose, j/6)) for j in range(6)]
wf[0].save(os.path.join(OUT, 'wall_sit.gif'), save_all=True,
    append_images=wf[1:], optimize=False, duration=150, loop=0)
print("✓  wall_sit.gif")

# bulgarian_split_squat.gif
def draw_chair(d):
    d.rectangle([(195, 190), (265, 268)], fill=(90, 65, 45))
    d.rectangle([(195, 182), (265, 195)], fill=(110, 80, 55))

bss_up = {
    'hd': (150, 60), 'neck': (150, 78),
    'shl': (130, 94), 'shr': (170, 94),
    'ell': (118, 132), 'elr': (182, 132),
    'hdl': (113, 164), 'hdr': (187, 164),
    'hip': (148, 172),
    'knl': (138, 218), 'knr': (215, 192),
    'ftl': (132, 265), 'ftr': (218, 190),
}
bss_dn = {
    'hd': (150, 82), 'neck': (150, 100),
    'shl': (130, 116), 'shr': (170, 116),
    'ell': (118, 153), 'elr': (182, 153),
    'hdl': (113, 185), 'hdr': (187, 185),
    'hip': (148, 193),
    'knl': (138, 240), 'knr': (215, 210),
    'ftl': (132, 265), 'ftr': (218, 190),
}
def render_bss(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d)
    draw_chair(d)
    for (a, b) in CONN_STD:
        if a in pose and b in pose: ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose: draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

bss_frames = [render_bss(lp(bss_up, bss_dn, j/8)) for j in range(8)] + \
             [render_bss(lp(bss_dn, bss_up, j/8)) for j in range(8)]
bss_frames[0].save(os.path.join(OUT, 'bulgarian_split_squat.gif'), save_all=True,
    append_images=bss_frames[1:], optimize=False, duration=100, loop=0)
print("✓  bulgarian_split_squat.gif")

# ──────────────────────────────────────────────────────────────────────────
# SHOULDERS EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# pike_pushup.gif  (inverted V)
pik_up = {
    'hd': (150, 110), 'neck': (150, 128),
    'shl': (130, 142), 'shr': (170, 142),
    'ell': (112, 162), 'elr': (188, 162),
    'hdl': (96,  190), 'hdr': (204, 190),
    'hip': (150, 188),
    'knl': (148, 220), 'knr': (152, 220),
    'ftl': (142, 265), 'ftr': (158, 265),
}
pik_dn = {
    'hd': (150, 128), 'neck': (150, 145),
    'shl': (130, 157), 'shr': (170, 157),
    'ell': (112, 175), 'elr': (188, 175),
    'hdl': (96,  198), 'hdr': (204, 198),
    'hip': (150, 195),
    'knl': (148, 225), 'knr': (152, 225),
    'ftl': (142, 265), 'ftr': (158, 265),
}
save_gif(make_frames([pik_up, pik_dn], 8), 'pike_pushup.gif')

# arm_circles.gif  (standing arms rotating)
def arm_circle_pose(angle_deg):
    a = math.radians(angle_deg)
    cx_l, cy_l = 124, 83   # left shoulder
    cx_r, cy_r = 176, 83   # right shoulder
    r = 50
    return {
        **STAND,
        'ell': (int(cx_l + r * 0.6 * math.cos(a)), int(cy_l + r * 0.6 * math.sin(a))),
        'hdl': (int(cx_l + r * math.cos(a)), int(cy_l + r * math.sin(a))),
        'elr': (int(cx_r + r * 0.6 * math.cos(a + math.pi)), int(cy_r + r * 0.6 * math.sin(a + math.pi))),
        'hdr': (int(cx_r + r * math.cos(a + math.pi)), int(cy_r + r * math.sin(a + math.pi))),
    }

ac_frames_data = [arm_circle_pose(i * 30) for i in range(12)]
ac_imgs = [render_frame(f) for f in ac_frames_data]
ac_imgs[0].save(os.path.join(OUT, 'arm_circles.gif'), save_all=True,
    append_images=ac_imgs[1:], optimize=False, duration=80, loop=0)
print("✓  arm_circles.gif")

# plank_shoulder_tap.gif
pst1 = {
    'hd': (238, 107), 'neck': (222, 115),
    'shl': (205, 120), 'shr': (210, 128),
    'ell': (195, 140), 'elr': (202, 148),
    'hdl': (186, 165), 'hdr': (193, 173),
    'hip': (165, 128), 'knl': (117, 132), 'knr': (120, 140),
    'ftl': (65, 140), 'ftr': (68, 148),
}
pst2 = {  # left hand taps right shoulder
    'hd': (238, 107), 'neck': (222, 115),
    'shl': (205, 120), 'shr': (210, 128),
    'ell': (210, 130), 'elr': (202, 148),
    'hdl': (210, 128), 'hdr': (193, 173),   # hand touches other shoulder
    'hip': (165, 128), 'knl': (117, 132), 'knr': (120, 140),
    'ftl': (65, 140), 'ftr': (68, 148),
}
save_gif(make_frames([pst1, pst2, pst1], 6), 'plank_shoulder_tap.gif', ground=False, gy=268)

# prone_t_raise.gif  (T shape arms)
pt1 = {**PRONE}
pt2 = {
    'hd': (255, 196), 'neck': (237, 198),
    'shl': (218, 198), 'shr': (222, 205),
    'ell': (218, 192), 'elr': (222, 198),
    'hdl': (218, 185), 'hdr': (222, 192),
    'hip': (172, 200), 'knl': (124, 202), 'knr': (127, 208),
    'ftl': (72, 205), 'ftr': (75, 211),
}
save_gif(make_frames([pt1, pt2, pt2, pt1], 6), 'prone_t_raise.gif', ground=False, gy=268)

# wall_slide.gif  (arms slide up wall)
ws1 = {
    'hd': (140, 50), 'neck': (145, 68),
    'shl': (128, 85), 'shr': (165, 85),
    'ell': (115, 118), 'elr': (172, 118),
    'hdl': (108, 148), 'hdr': (178, 148),
    'hip': (148, 165),
    'knl': (138, 215), 'knr': (162, 215),
    'ftl': (132, 265), 'ftr': (168, 265),
}
ws2 = {
    'hd': (140, 50), 'neck': (145, 68),
    'shl': (128, 85), 'shr': (165, 85),
    'ell': (120, 100), 'elr': (165, 100),
    'hdl': (125, 72),  'hdr': (162, 72),
    'hip': (148, 165),
    'knl': (138, 215), 'knr': (162, 215),
    'ftl': (132, 265), 'ftr': (168, 265),
}
def render_wall_slide(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d, wall=True)
    for (a, b) in CONN_STD:
        if a in pose and b in pose: ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose: draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

wsf = [render_wall_slide(lp(ws1, ws2, j/8)) for j in range(8)] + \
      [render_wall_slide(lp(ws2, ws1, j/8)) for j in range(8)]
wsf[0].save(os.path.join(OUT, 'wall_slide.gif'), save_all=True,
    append_images=wsf[1:], optimize=False, duration=100, loop=0)
print("✓  wall_slide.gif")

# inchworm_pike.gif  (walk out to pike push-up)
inch1 = {**STAND}
inch2 = {  # bent forward
    'hd': (150, 95), 'neck': (150, 110),
    'shl': (135, 120), 'shr': (165, 120),
    'ell': (120, 148), 'elr': (180, 148),
    'hdl': (108, 178), 'hdr': (192, 178),
    'hip': (148, 158),
    'knl': (140, 208), 'knr': (160, 208),
    'ftl': (132, 258), 'ftr': (168, 258),
}
inch3 = {  # pike position
    'hd': (150, 112), 'neck': (150, 130),
    'shl': (130, 144), 'shr': (170, 144),
    'ell': (112, 162), 'elr': (188, 162),
    'hdl': (96,  188), 'hdr': (204, 188),
    'hip': (150, 188),
    'knl': (148, 222), 'knr': (152, 222),
    'ftl': (142, 265), 'ftr': (158, 265),
}
save_gif(make_frames([inch1, inch2, inch3, inch2], 5), 'inchworm_pike.gif')

# ──────────────────────────────────────────────────────────────────────────
# ARMS EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# bench_dips.gif
def draw_chair2(d):
    d.rectangle([(80, 188), (220, 270)], fill=(90, 65, 45))
    d.rectangle([(80, 180), (220, 193)], fill=(110, 80, 55))

bd_up = {
    'hd': (150, 92), 'neck': (150, 108),
    'shl': (118, 118), 'shr': (182, 118),
    'ell': (108, 152), 'elr': (192, 152),
    'hdl': (102, 185), 'hdr': (198, 185),
    'hip': (150, 188),
    'knl': (130, 232), 'knr': (170, 232),
    'ftl': (120, 265), 'ftr': (180, 265),
}
bd_dn = {
    'hd': (150, 115), 'neck': (150, 132),
    'shl': (118, 140), 'shr': (182, 140),
    'ell': (108, 168), 'elr': (192, 168),
    'hdl': (102, 188), 'hdr': (198, 188),
    'hip': (150, 210),
    'knl': (130, 248), 'knr': (170, 248),
    'ftl': (120, 265), 'ftr': (180, 265),
}
def render_bench_dip(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d)
    draw_chair2(d)
    for (a, b) in CONN_STD:
        if a in pose and b in pose: ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose: draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

bd_frames = [render_bench_dip(lp(bd_up, bd_dn, j/8)) for j in range(8)] + \
            [render_bench_dip(lp(bd_dn, bd_up, j/8)) for j in range(8)]
bd_frames[0].save(os.path.join(OUT, 'bench_dips.gif'), save_all=True,
    append_images=bd_frames[1:], optimize=False, duration=100, loop=0)
print("✓  bench_dips.gif")

# towel_curl.gif  (bicep curl motion)
tc1 = {**STAND, 'ell': (112, 145), 'elr': (188, 145), 'hdl': (110, 180), 'hdr': (190, 180)}
tc2 = {**STAND, 'ell': (118, 122), 'elr': (182, 122), 'hdl': (125, 98), 'hdr': (175, 98)}
save_gif(make_frames([tc1, tc2], 8), 'towel_curl.gif')

# chaturanga.gif  (low plank)
ch_pose = {
    'hd': (238, 120), 'neck': (222, 128),
    'shl': (205, 133), 'shr': (210, 141),
    'ell': (198, 152), 'elr': (202, 160),
    'hdl': (188, 175), 'hdr': (192, 183),
    'hip': (162, 138), 'knl': (114, 142), 'knr': (117, 150),
    'ftl': (62, 148), 'ftr': (65, 156),
}
ch2 = {**ch_pose, 'hd': (239, 121)}  # tiny variation for pulse effect
save_gif(make_frames([ch_pose, ch2, ch_pose], 5), 'chaturanga.gif', ground=False, gy=268)

# tricep_kickback.gif  (bent over, arm extends)
tk1 = {
    'hd': (200, 82), 'neck': (192, 98),
    'shl': (175, 110), 'shr': (185, 118),
    'ell': (165, 135), 'elr': (178, 142),
    'hdl': (155, 160), 'hdr': (168, 165),
    'hip': (148, 148),
    'knl': (140, 195), 'knr': (158, 195),
    'ftl': (132, 248), 'ftr': (162, 248),
}
tk2 = {
    'hd': (200, 82), 'neck': (192, 98),
    'shl': (175, 110), 'shr': (185, 118),
    'ell': (165, 135), 'elr': (178, 142),
    'hdl': (142, 118), 'hdr': (152, 125),
    'hip': (148, 148),
    'knl': (140, 195), 'knr': (158, 195),
    'ftl': (132, 248), 'ftr': (162, 248),
}
save_gif(make_frames([tk1, tk2], 8), 'tricep_kickback.gif')

# doorframe_curl.gif  (pulling motion)
def draw_door(d):
    d.rectangle([(215, 50), (240, 274)], fill=(90, 65, 45))
    d.line([(215, 50), (215, 274)], fill=(70, 50, 30), width=3)

dc1 = {  # leaned back holding doorframe
    'hd': (148, 65), 'neck': (155, 82),
    'shl': (142, 96), 'shr': (175, 96),
    'ell': (168, 125), 'elr': (192, 125),
    'hdl': (195, 148), 'hdr': (212, 148),
    'hip': (155, 175),
    'knl': (148, 225), 'knr': (165, 225),
    'ftl': (200, 265), 'ftr': (215, 265),
}
dc2 = {  # pulled in
    'hd': (162, 65), 'neck': (168, 82),
    'shl': (152, 96), 'shr': (182, 96),
    'ell': (178, 118), 'elr': (205, 118),
    'hdl': (205, 135), 'hdr': (215, 135),
    'hip': (165, 175),
    'knl': (158, 225), 'knr': (175, 225),
    'ftl': (210, 265), 'ftr': (220, 265),
}
def render_doorframe(pose):
    img = Image.new('RGB', (W, H))
    d = ImageDraw.Draw(img)
    draw_bg(d)
    draw_door(d)
    for (a, b) in CONN_STD:
        if a in pose and b in pose: ln(d, pose[a], pose[b])
    for k in ['neck','shl','shr','ell','elr','hdl','hdr','hip','knl','knr']:
        if k in pose: draw_joint(d, pose[k])
    if 'hd' in pose: draw_head(d, pose['hd'][0], pose['hd'][1])
    return img

df_frames = [render_doorframe(lp(dc1, dc2, j/8)) for j in range(8)] + \
            [render_doorframe(lp(dc2, dc1, j/8)) for j in range(8)]
df_frames[0].save(os.path.join(OUT, 'doorframe_curl.gif'), save_all=True,
    append_images=df_frames[1:], optimize=False, duration=100, loop=0)
print("✓  doorframe_curl.gif")

# shadow_boxing.gif  (punching)
sb1 = {**STAND, 'ell': (120, 108), 'elr': (185, 108), 'hdl': (108, 88), 'hdr': (195, 110)}
sb2 = {**STAND, 'ell': (118, 105), 'elr': (195, 108), 'hdl': (105, 80), 'hdr': (215, 110)}
sb3 = {**STAND, 'ell': (122, 105), 'elr': (190, 105), 'hdl': (112, 82), 'hdr': (210, 82)}
save_gif(make_frames([sb1, sb2, sb3, sb1], 4), 'shadow_boxing.gif', dur=80)

# ──────────────────────────────────────────────────────────────────────────
# ABS EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# crunch.gif  (supine, shoulder blades up)
cr_dn = {**SUPINE}
cr_up = {
    'hd': (75, 195), 'neck': (92, 198),
    'shl': (108, 198), 'shr': (113, 206),
    'ell': (125, 195), 'elr': (128, 202),
    'hdl': (140, 198), 'hdr': (142, 205),
    'hip': (168, 212), 'knl': (205, 215), 'knr': (208, 222),
    'ftl': (245, 218), 'ftr': (248, 225),
}
save_gif(make_frames([cr_dn, cr_up], 8), 'crunch.gif', ground=False, gy=255)

# bicycle_crunch.gif
bc1 = {  # right elbow to left knee
    'hd': (78, 195), 'neck': (93, 200),
    'shl': (108, 198), 'shr': (115, 207),
    'ell': (130, 195), 'elr': (120, 205),
    'hdl': (152, 200), 'hdr': (130, 225),
    'hip': (168, 212),
    'knl': (192, 208), 'knr': (215, 228),
    'ftl': (215, 195), 'ftr': (248, 228),
}
bc2 = {  # left elbow to right knee
    'hd': (78, 195), 'neck': (93, 200),
    'shl': (108, 198), 'shr': (115, 207),
    'ell': (125, 207), 'elr': (132, 195),
    'hdl': (135, 228), 'hdr': (158, 205),
    'hip': (168, 212),
    'knl': (215, 228), 'knr': (192, 208),
    'ftl': (248, 228), 'ftr': (215, 195),
}
save_gif(make_frames([bc1, bc2], 6), 'bicycle_crunch.gif', ground=False, gy=255)

# russian_twist.gif  (seated, twist side to side)
rt_base = {
    'hd': (150, 108), 'neck': (150, 126),
    'shl': (130, 140), 'shr': (170, 140),
    'ell': (118, 168), 'elr': (182, 168),
    'hdl': (115, 190), 'hdr': (185, 190),
    'hip': (148, 185),
    'knl': (128, 232), 'knr': (172, 232),
    'ftl': (115, 262), 'ftr': (185, 262),
}
rt1 = {**rt_base, 'hdl': (98, 172), 'hdr': (162, 172), 'ell': (102, 168), 'elr': (165, 168)}
rt2 = {**rt_base, 'hdl': (138, 172), 'hdr': (202, 172), 'ell': (135, 168), 'elr': (198, 168)}
save_gif(make_frames([rt1, rt2], 6), 'russian_twist.gif')

# leg_raise.gif  (supine, legs up)
lr_dn = {**SUPINE}
lr_up = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (112, 210), 'elr': (115, 218),
    'hdl': (130, 210), 'hdr': (132, 218),
    'hip': (168, 212),
    'knl': (200, 182), 'knr': (204, 190),
    'ftl': (234, 148), 'ftr': (238, 156),
}
save_gif(make_frames([lr_dn, lr_up], 8), 'leg_raise.gif', ground=False, gy=255)

# flutter_kicks.gif
fk1 = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (112, 210), 'elr': (115, 218),
    'hdl': (130, 210), 'hdr': (132, 218),
    'hip': (168, 212),
    'knl': (202, 202), 'knr': (205, 222),
    'ftl': (238, 192), 'ftr': (242, 232),
}
fk2 = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (112, 210), 'elr': (115, 218),
    'hdl': (130, 210), 'hdr': (132, 218),
    'hip': (168, 212),
    'knl': (202, 222), 'knr': (205, 202),
    'ftl': (238, 232), 'ftr': (242, 192),
}
save_gif(make_frames([fk1, fk2], 4), 'flutter_kicks.gif', dur=70, ground=False, gy=255)

# v_up.gif
vu_dn = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (112, 195), 'elr': (115, 205),
    'hdl': (112, 178), 'hdr': (115, 188),
    'hip': (168, 212),
    'knl': (205, 215), 'knr': (208, 222),
    'ftl': (245, 218), 'ftr': (248, 225),
}
vu_up = {
    'hd': (108, 170), 'neck': (120, 178),
    'shl': (132, 183), 'shr': (138, 190),
    'ell': (148, 188), 'elr': (153, 195),
    'hdl': (165, 193), 'hdr': (170, 200),
    'hip': (168, 192),
    'knl': (195, 182), 'knr': (200, 190),
    'ftl': (225, 168), 'ftr': (230, 176),
}
save_gif(make_frames([vu_dn, vu_up], 8), 'v_up.gif', ground=False, gy=255)

# ──────────────────────────────────────────────────────────────────────────
# CORE EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# plank.gif  (high plank)
plk = {
    'hd': (240, 110), 'neck': (222, 118),
    'shl': (205, 124), 'shr': (210, 132),
    'ell': (196, 143), 'elr': (200, 151),
    'hdl': (185, 168), 'hdr': (188, 176),
    'hip': (163, 130), 'knl': (115, 134), 'knr': (118, 142),
    'ftl': (63, 142), 'ftr': (66, 150),
}
plk2 = {**plk, 'hd': (241, 111)}
save_gif(make_frames([plk, plk2, plk], 5), 'plank.gif', ground=False, gy=268)

# side_plank.gif
sp = {
    'hd': (238, 98), 'neck': (228, 112),
    'shl': (215, 125), 'shr': (225, 133),
    'ell': (205, 150), 'elr': (220, 140),
    'hdl': (195, 178), 'hdr': (218, 112),
    'hip': (162, 152), 'knl': (118, 162), 'knr': (122, 170),
    'ftl': (72, 175), 'ftr': (75, 182),
}
sp2 = {**sp, 'hd': (239, 99)}
save_gif(make_frames([sp, sp2, sp], 5), 'side_plank.gif', ground=False, gy=268)

# dead_bug.gif  (supine, alternate limbs)
db1 = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (95, 188), 'elr': (120, 228),
    'hdl': (95, 165), 'hdr': (148, 248),
    'hip': (168, 212),
    'knl': (190, 195), 'knr': (218, 232),
    'ftl': (225, 180), 'ftr': (252, 240),
}
db2 = {
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (118, 228), 'elr': (96, 188),
    'hdl': (148, 248), 'hdr': (96, 165),
    'hip': (168, 212),
    'knl': (218, 232), 'knr': (190, 195),
    'ftl': (252, 240), 'ftr': (225, 180),
}
save_gif(make_frames([db1, db2], 8), 'dead_bug.gif', ground=False, gy=255)

# hollow_body.gif
hb = {
    'hd': (65, 202), 'neck': (82, 205),
    'shl': (100, 202), 'shr': (104, 210),
    'ell': (118, 198), 'elr': (122, 206),
    'hdl': (118, 182), 'hdr': (122, 190),
    'hip': (168, 210),
    'knl': (202, 205), 'knr': (206, 213),
    'ftl': (240, 200), 'ftr': (244, 208),
}
hb2 = {**hb, 'hd': (66, 203)}
save_gif(make_frames([hb, hb2, hb], 5), 'hollow_body.gif', ground=False, gy=255)

# plank_hip_twist.gif
pht_c = {**plk}
pht_r = {**plk, 'hip': (163, 138), 'knl': (118, 142), 'knr': (121, 150)}
pht_l = {**plk, 'hip': (163, 122), 'knl': (112, 126), 'knr': (115, 134)}
save_gif(make_frames([pht_c, pht_r, pht_c, pht_l], 5), 'plank_hip_twist.gif', ground=False, gy=268)

# ──────────────────────────────────────────────────────────────────────────
# FULL BODY EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# burpee.gif  (squat → plank → jump)
bur_stand = {**STAND}
bur_squat = {**SQUAT_BOT}
bur_plank = {**plk}
bur_jump = {
    'hd': (150, 22), 'neck': (150, 40),
    'shl': (124, 58), 'shr': (176, 58),
    'ell': (102, 45), 'elr': (198, 45),
    'hdl': (88, 32), 'hdr': (212, 32),
    'hip': (148, 130),
    'knl': (135, 172), 'knr': (165, 172),
    'ftl': (125, 220), 'ftr': (175, 220),
}
save_gif(make_frames([bur_stand, bur_squat, bur_plank, bur_squat, bur_jump], 5), 'burpee.gif', dur=120)

# mountain_climbers.gif  (plank + alternating knees)
mc_base = {**plk}
mc1 = {**plk, 'knl': (148, 130), 'ftl': (148, 130)}  # left knee forward
mc2 = {**plk, 'knr': (148, 138), 'ftr': (148, 138)}  # right knee forward
save_gif(make_frames([mc_base, mc1, mc_base, mc2], 4), 'mountain_climbers.gif', dur=80, ground=False, gy=268)

# high_knees.gif  (running in place, knees up)
hk1 = {
    'hd': (150, 47), 'neck': (150, 65),
    'shl': (124, 82), 'shr': (176, 82),
    'ell': (188, 108), 'elr': (112, 108),
    'hdl': (195, 135), 'hdr': (105, 135),
    'hip': (148, 162),
    'knl': (138, 210), 'knr': (158, 158),
    'ftl': (130, 260), 'ftr': (162, 162),
}
hk2 = {
    'hd': (150, 47), 'neck': (150, 65),
    'shl': (124, 82), 'shr': (176, 82),
    'ell': (112, 108), 'elr': (188, 108),
    'hdl': (105, 135), 'hdr': (195, 135),
    'hip': (148, 162),
    'knl': (140, 158), 'knr': (162, 210),
    'ftl': (142, 162), 'ftr': (168, 260),
}
save_gif(make_frames([hk1, hk2], 5), 'high_knees.gif', dur=80)

# inchworm.gif
save_gif(make_frames([STAND, inch2, inch3, inch2, STAND], 4), 'inchworm.gif', dur=120)

# ──────────────────────────────────────────────────────────────────────────
# RECOVERY EXERCISES
# ──────────────────────────────────────────────────────────────────────────

# child_pose.gif
cp = {
    'hd': (245, 220), 'neck': (225, 215),
    'shl': (205, 210), 'shr': (210, 218),
    'ell': (185, 205), 'elr': (190, 212),
    'hdl': (162, 200), 'hdr': (167, 208),
    'hip': (158, 210),
    'knl': (155, 238), 'knr': (158, 245),
    'ftl': (145, 265), 'ftr': (148, 270),
}
cp2 = {**cp, 'hd': (246, 221)}
save_gif(make_frames([cp, cp2, cp], 6), 'child_pose.gif', ground=False, gy=268)

# cat_cow.gif
cat = {**ALLFOURS,
    'neck': (225, 192), 'hd': (245, 188),
    'hip': (152, 195), 'shl': (210, 198), 'shr': (215, 206),
}
cow = {**ALLFOURS,
    'neck': (228, 168), 'hd': (248, 160),
    'hip': (152, 168), 'shl': (210, 175), 'shr': (215, 182),
}
save_gif(make_frames([cat, cow], 8), 'cat_cow.gif', ground=False, gy=268)

# hamstring_stretch.gif  (seated forward fold)
hs_up = {
    'hd': (150, 118), 'neck': (150, 136),
    'shl': (128, 150), 'shr': (172, 150),
    'ell': (115, 178), 'elr': (185, 178),
    'hdl': (108, 205), 'hdr': (192, 205),
    'hip': (148, 190),
    'knl': (128, 225), 'knr': (170, 225),
    'ftl': (115, 265), 'ftr': (185, 265),
}
hs_dn = {
    'hd': (150, 138), 'neck': (150, 155),
    'shl': (128, 168), 'shr': (172, 168),
    'ell': (118, 190), 'elr': (182, 190),
    'hdl': (115, 225), 'hdr': (185, 225),
    'hip': (148, 190),
    'knl': (128, 225), 'knr': (170, 225),
    'ftl': (115, 265), 'ftr': (185, 265),
}
save_gif(make_frames([hs_up, hs_dn, hs_dn, hs_up], 6), 'hamstring_stretch.gif')

# quad_stretch.gif  (standing, foot to glute)
qs1 = {**STAND}
qs2 = {
    'hd': (150, 47), 'neck': (150, 65),
    'shl': (124, 82), 'shr': (176, 82),
    'ell': (108, 122), 'elr': (185, 108),
    'hdl': (102, 157), 'hdr': (178, 148),
    'hip': (148, 162),
    'knl': (136, 212), 'knr': (160, 195),
    'ftl': (130, 262), 'ftr': (163, 168),
}
save_gif(make_frames([qs1, qs2, qs2, qs1], 6), 'quad_stretch.gif')

# shoulder_rolls.gif  (rolling circles)
def shoulder_roll_pose(angle_deg):
    a = math.radians(angle_deg)
    r = 28
    return {
        **STAND,
        'shl': (int(124 + r * math.cos(a)), int(83 + r * math.sin(a))),
        'shr': (int(176 + r * math.cos(a + math.pi)), int(83 + r * math.sin(a + math.pi))),
        'ell': (int(112 + r * math.cos(a)), int(122 + r * math.sin(a))),
        'elr': (int(188 + r * math.cos(a + math.pi)), int(122 + r * math.sin(a + math.pi))),
    }
sr_frames = [render_frame(shoulder_roll_pose(i * 30)) for i in range(12)]
sr_frames[0].save(os.path.join(OUT, 'shoulder_rolls.gif'), save_all=True,
    append_images=sr_frames[1:], optimize=False, duration=80, loop=0)
print("✓  shoulder_rolls.gif")

# hip_flexor_stretch.gif  (kneeling lunge)
hf = {
    'hd': (150, 62), 'neck': (150, 80),
    'shl': (130, 96), 'shr': (170, 96),
    'ell': (118, 132), 'elr': (182, 132),
    'hdl': (112, 165), 'hdr': (188, 165),
    'hip': (148, 172),
    'knl': (175, 220), 'knr': (118, 248),
    'ftl': (182, 265), 'ftr': (108, 265),
}
hf2 = {**hf, 'hip': (152, 168), 'hd': (152, 58)}
save_gif(make_frames([hf, hf2, hf], 6), 'hip_flexor_stretch.gif')

# puppy_dog.gif  (on all fours, chest to floor)
pd1 = {**ALLFOURS}
pd2 = {
    'hd': (248, 218), 'neck': (228, 212),
    'shl': (210, 205), 'shr': (214, 212),
    'ell': (198, 205), 'elr': (202, 212),
    'hdl': (182, 215), 'hdr': (186, 222),
    'hip': (152, 182), 'knl': (148, 218), 'knr': (151, 225),
    'ftl': (147, 248), 'ftr': (150, 254),
}
save_gif(make_frames([pd1, pd2, pd2, pd1], 6), 'puppy_dog.gif', ground=False, gy=268)

# butterfly_stretch.gif  (seated, knees open/close)
bs1 = {
    'hd': (150, 100), 'neck': (150, 118),
    'shl': (130, 132), 'shr': (170, 132),
    'ell': (118, 158), 'elr': (182, 158),
    'hdl': (115, 185), 'hdr': (185, 185),
    'hip': (148, 182),
    'knl': (110, 230), 'knr': (190, 230),
    'ftl': (148, 255), 'ftr': (152, 255),
}
bs2 = {**bs1, 'knl': (125, 222), 'knr': (175, 222)}
save_gif(make_frames([bs1, bs2], 8), 'butterfly_stretch.gif')

# thread_needle.gif  (on all fours, arm thread)
tn1 = {**ALLFOURS}
tn2 = {
    'hd': (225, 220), 'neck': (228, 200),
    'shl': (210, 186), 'shr': (214, 194),
    'ell': (195, 195), 'elr': (211, 224),
    'hdl': (175, 212), 'hdr': (210, 254),
    'hip': (152, 182), 'knl': (148, 218), 'knr': (151, 225),
    'ftl': (147, 248), 'ftr': (150, 254),
}
save_gif(make_frames([tn1, tn2, tn2, tn1], 6), 'thread_needle.gif', ground=False, gy=268)

# spinal_twist.gif  (lying, knees to side)
st1 = {  # knees right
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (78, 210), 'elr': (115, 218),
    'hdl': (60, 210), 'hdr': (132, 218),
    'hip': (168, 212),
    'knl': (190, 232), 'knr': (195, 242),
    'ftl': (218, 248), 'ftr': (222, 258),
}
st2 = {  # knees left
    'hd': (55, 212), 'neck': (73, 213),
    'shl': (92, 210), 'shr': (96, 218),
    'ell': (78, 210), 'elr': (115, 218),
    'hdl': (60, 210), 'hdr': (132, 218),
    'hip': (168, 212),
    'knl': (175, 192), 'knr': (180, 202),
    'ftl': (203, 178), 'ftr': (208, 188),
}
save_gif(make_frames([st1, st2], 8), 'spinal_twist.gif', ground=False, gy=255)

# ──────────────────────────────────────────────────────────────────────────
# YOGA POSES
# ──────────────────────────────────────────────────────────────────────────

# mountain_pose.gif  (tall, arms at sides)
mt1 = {**STAND}
mt2 = {**STAND, 'hd': (150, 44)}  # slight chest lift
save_gif(make_frames([mt1, mt2, mt1], 6), 'mountain_pose.gif')

# downward_dog.gif  (inverted V)
dd = {
    'hd': (150, 118), 'neck': (150, 135),
    'shl': (128, 148), 'shr': (172, 148),
    'ell': (110, 165), 'elr': (190, 165),
    'hdl': (95, 192), 'hdr': (205, 192),
    'hip': (148, 190),
    'knl': (142, 235), 'knr': (158, 235),
    'ftl': (135, 265), 'ftr': (165, 265),
}
dd2 = {**dd, 'hip': (148, 186)}
save_gif(make_frames([dd, dd2, dd], 6), 'downward_dog.gif')

# warrior_1.gif  (wide lunge, arms up)
w1 = {
    'hd': (150, 40), 'neck': (150, 58),
    'shl': (128, 75), 'shr': (172, 75),
    'ell': (118, 48), 'elr': (182, 48),
    'hdl': (115, 25), 'hdr': (185, 25),
    'hip': (148, 162),
    'knl': (178, 210), 'knr': (112, 245),
    'ftl': (185, 265), 'ftr': (100, 265),
}
w1b = {**w1, 'hd': (150, 38)}
save_gif(make_frames([w1, w1b, w1], 5), 'warrior_1.gif')

# warrior_2.gif  (wide, arms extended sides)
w2 = {
    'hd': (150, 55), 'neck': (150, 73),
    'shl': (128, 88), 'shr': (172, 88),
    'ell': (88,  88), 'elr': (212, 88),
    'hdl': (55,  88), 'hdr': (245, 88),
    'hip': (148, 165),
    'knl': (175, 212), 'knr': (115, 242),
    'ftl': (185, 265), 'ftr': (102, 265),
}
w2b = {**w2, 'hd': (150, 53)}
save_gif(make_frames([w2, w2b, w2], 5), 'warrior_2.gif')

# triangle_pose.gif  (side bend)
tri = {
    'hd': (118, 75), 'neck': (125, 92),
    'shl': (112, 107), 'shr': (155, 107),
    'ell': (98, 132), 'elr': (162, 80),
    'hdl': (90, 160), 'hdr': (168, 55),
    'hip': (148, 175),
    'knl': (118, 225), 'knr': (178, 225),
    'ftl': (100, 265), 'ftr': (200, 265),
}
tri2 = {**tri, 'hd': (119, 76)}
save_gif(make_frames([tri, tri2, tri], 6), 'triangle_pose.gif')

# tree_pose.gif  (balance)
tree = {
    'hd': (150, 40), 'neck': (150, 58),
    'shl': (128, 72), 'shr': (172, 72),
    'ell': (115, 45), 'elr': (185, 45),
    'hdl': (135, 25), 'hdr': (165, 25),
    'hip': (150, 155),
    'knl': (142, 205), 'knr': (175, 195),
    'ftl': (140, 262), 'ftr': (148, 210),
}
tree2 = {**tree, 'hd': (150, 38)}
save_gif(make_frames([tree, tree2, tree], 6), 'tree_pose.gif')

# pigeon_pose.gif  (hip opener)
pig = {
    'hd': (205, 85), 'neck': (195, 102),
    'shl': (178, 115), 'shr': (215, 115),
    'ell': (162, 140), 'elr': (228, 140),
    'hdl': (148, 168), 'hdr': (242, 168),
    'hip': (148, 178),
    'knl': (108, 210), 'knr': (128, 245),
    'ftl': (85, 248), 'ftr': (125, 265),
}
pig2 = {**pig, 'hd': (206, 86)}
save_gif(make_frames([pig, pig2, pig], 6), 'pigeon_pose.gif')

# corpse_pose.gif  (lying flat)
corp = {**SUPINE,
    'ell': (68, 238), 'elr': (140, 238),
    'hdl': (42, 265), 'hdr': (155, 258),
}
corp2 = {**corp, 'hd': (56, 213)}
save_gif(make_frames([corp, corp2, corp], 8), 'corpse_pose.gif', ground=False, gy=255, dur=200)

# plow_pose.gif  (legs over head)
plow = {
    'hd': (60, 218), 'neck': (78, 210),
    'shl': (95, 200), 'shr': (99, 208),
    'ell': (100, 228), 'elr': (103, 235),
    'hdl': (105, 255), 'hdr': (108, 262),
    'hip': (168, 188),
    'knl': (200, 158), 'knr': (204, 165),
    'ftl': (238, 130), 'ftr': (242, 137),
}
plow2 = {**plow, 'ftl': (235, 128), 'ftr': (239, 135)}
save_gif(make_frames([plow, plow2, plow], 6), 'plow_pose.gif', ground=False, gy=268)

# boat_pose.gif  (V balance)
boat = {
    'hd': (150, 95), 'neck': (150, 113),
    'shl': (130, 128), 'shr': (170, 128),
    'ell': (115, 155), 'elr': (185, 155),
    'hdl': (110, 182), 'hdr': (190, 182),
    'hip': (148, 180),
    'knl': (178, 155), 'knr': (185, 162),
    'ftl': (212, 128), 'ftr': (218, 135),
}
boat2 = {**boat, 'hd': (150, 93)}
save_gif(make_frames([boat, boat2, boat], 6), 'boat_pose.gif')

# ──────────────────────────────────────────────────────────────────────────
print("\n=== All exercise GIFs generated! ===")
print(f"Output directory: {OUT}")
