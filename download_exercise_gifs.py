#!/usr/bin/env python3
"""
Downloads REAL HUMAN exercise GIFs from the free ExerciseDB API
(https://oss.exercisedb.dev) for all exercises in the workout app.
No API key required.
"""

import json
import os
import time
import urllib.request
import urllib.parse

OUT = '/Users/harshjaiswal/Desktop/flutter project/workout/assets/gifs'
os.makedirs(OUT, exist_ok=True)

BASE_API = 'https://oss.exercisedb.dev/api/v1/exercises'

# ─── Map: our GIF filename → search terms to try (in order) ──────────────
EXERCISE_SEARCH_MAP = {
    # CHEST
    'standard push up.gif':   ['push up', 'pushup', 'standard push'],
    'wide_pushup.gif':        ['wide push', 'wide grip push', 'wide pushup'],
    'diamond_pushup.gif':     ['diamond push', 'close grip push', 'triangle push'],
    'incline_pushup.gif':     ['incline push', 'elevated push'],
    'decline_pushup.gif':     ['decline push', 'feet elevated push'],
    'chest_squeeze.gif':      ['chest squeeze', 'chest press', 'isometric chest'],

    # BACK
    'superman.gif':           ['superman', 'superman hold', 'back extension'],
    'cobra.gif':              ['cobra', 'cobra stretch', 'sphinx', 'upward facing dog'],
    'reverse_snow_angel.gif': ['reverse snow angel', 'prone reverse', 'back fly'],
    'bird_dog.gif':           ['bird dog', 'birddog', 'quadruped'],
    'prone_y_raise.gif':      ['prone y', 'y raise', 'prone raise'],
    'prone_w_extension.gif':  ['prone w', 'w extension', 'prone extension', 'face pull'],

    # LEGS
    'squat.gif':              ['squat', 'bodyweight squat', 'air squat'],
    'sumo_squat.gif':         ['sumo squat', 'wide squat', 'plie squat'],
    'lunge.gif':              ['forward lunge', 'lunge', 'walking lunge'],
    'reverse_lunge.gif':      ['reverse lunge', 'backward lunge', 'step back lunge'],
    'glute_bridge.gif':       ['glute bridge', 'hip bridge', 'bridge'],
    'calf_raise.gif':         ['calf raise', 'standing calf', 'heel raise'],
    'wall_sit.gif':           ['wall sit', 'wall squat', 'isometric squat'],
    'bulgarian_split_squat.gif': ['bulgarian split', 'split squat', 'rear foot elevated'],

    # SHOULDERS
    'pike_pushup.gif':        ['pike push up', 'pike pushup', 'downward dog push'],
    'arm_circles.gif':        ['arm circle', 'shoulder circle'],
    'plank_shoulder_tap.gif': ['shoulder tap', 'plank shoulder tap', 'plank tap'],
    'prone_t_raise.gif':      ['prone t raise', 't raise', 'rear delt raise'],
    'wall_slide.gif':         ['wall slide', 'wall angel', 'shoulder slide'],
    'inchworm_pike.gif':      ['inchworm', 'inch worm', 'walk out'],

    # ARMS
    'bench_dips.gif':         ['bench dip', 'tricep dip', 'chair dip', 'dip'],
    'towel_curl.gif':         ['bicep curl', 'curl', 'isometric curl'],
    'chaturanga.gif':         ['chaturanga', 'low plank', 'four limbed staff'],
    'tricep_kickback.gif':    ['tricep kickback', 'triceps kickback'],
    'doorframe_curl.gif':     ['doorframe', 'bodyweight curl', 'inverted curl'],
    'shadow_boxing.gif':      ['shadow boxing', 'boxing', 'punch', 'jab'],

    # ABS
    'crunch.gif':             ['crunch', 'abdominal crunch', 'basic crunch'],
    'bicycle_crunch.gif':     ['bicycle crunch', 'bicycle', 'cross crunch'],
    'russian_twist.gif':      ['russian twist', 'seated twist', 'oblique twist'],
    'leg_raise.gif':          ['leg raise', 'lying leg raise', 'straight leg raise'],
    'flutter_kicks.gif':      ['flutter kick', 'flutter', 'scissor kick'],
    'v_up.gif':               ['v up', 'jackknife', 'pike crunch'],

    # CORE
    'plank.gif':              ['plank', 'high plank', 'front plank'],
    'side_plank.gif':         ['side plank', 'lateral plank'],
    'dead_bug.gif':           ['dead bug', 'dead bug exercise'],
    'hollow_body.gif':        ['hollow body', 'hollow hold', 'hollow rock'],
    'plank_hip_twist.gif':    ['plank twist', 'plank rotation', 'hip dip', 'side plank dip'],

    # FULL BODY
    'jumping jack.gif':       ['jumping jack', 'jumping jacks', 'side jack'],
    'burpee.gif':             ['burpee', 'burpees'],
    'mountain_climbers.gif':  ['mountain climber', 'mountain climbers'],
    'high_knees.gif':         ['high knee', 'high knees', 'running high'],
    'inchworm.gif':           ['inchworm', 'inch worm', 'walk out plank'],

    # RECOVERY
    'child_pose.gif':         ['child pose', 'childs pose', 'balasana'],
    'cat_cow.gif':            ['cat cow', 'cat camel', 'spinal flexion'],
    'hamstring_stretch.gif':  ['hamstring stretch', 'seated hamstring', 'forward fold'],
    'quad_stretch.gif':       ['quad stretch', 'quadriceps stretch', 'standing quad'],
    'shoulder_rolls.gif':     ['shoulder roll', 'neck roll', 'shoulder shrug'],
    'hip_flexor_stretch.gif': ['hip flexor', 'kneeling hip', 'lunge stretch'],
    'puppy_dog.gif':          ['puppy pose', 'extended puppy', 'puppy dog'],
    'butterfly_stretch.gif':  ['butterfly stretch', 'butterfly', 'seated butterfly', 'groin stretch'],
    'thread_needle.gif':      ['thread needle', 'thread the needle', 'spinal twist'],
    'spinal_twist.gif':       ['spinal twist', 'lying twist', 'supine twist'],

    # YOGA
    'mountain_pose.gif':      ['mountain pose', 'tadasana', 'standing pose'],
    'downward_dog.gif':       ['downward dog', 'downward facing dog', 'adho mukha'],
    'warrior_1.gif':          ['warrior 1', 'warrior one', 'virabhadrasana 1'],
    'warrior_2.gif':          ['warrior 2', 'warrior two', 'virabhadrasana 2'],
    'triangle_pose.gif':      ['triangle pose', 'trikonasana', 'triangle'],
    'tree_pose.gif':          ['tree pose', 'vrksasana', 'tree stand'],
    'pigeon_pose.gif':        ['pigeon pose', 'pigeon', 'hip opener'],
    'corpse_pose.gif':        ['corpse pose', 'savasana', 'relaxation'],
    'plow_pose.gif':          ['plow pose', 'halasana', 'plow'],
    'boat_pose.gif':          ['boat pose', 'navasana', 'boat'],
}

# ─── Fetch ALL exercises from the API (paginated) ─────────────────────────
def fetch_all_exercises():
    all_exercises = []
    cursor = None
    page = 0
    print("Fetching exercise database from API...")
    while True:
        url = f"{BASE_API}?limit=100"
        if cursor:
            url += f"&cursor={cursor}"
        try:
            req = urllib.request.Request(url, headers={'User-Agent': 'WorkoutApp/1.0'})
            with urllib.request.urlopen(req, timeout=15) as resp:
                data = json.loads(resp.read().decode())
            exercises = data.get('data', [])
            all_exercises.extend(exercises)
            page += 1
            print(f"  Page {page}: fetched {len(exercises)} exercises (total: {len(all_exercises)})")
            meta = data.get('meta', {})
            if not meta.get('hasNextPage') or not exercises:
                break
            cursor = meta.get('nextCursor')
            time.sleep(0.3)  # Be polite to the API
        except Exception as e:
            print(f"  Error fetching page {page}: {e}")
            break
    print(f"Total exercises fetched: {len(all_exercises)}\n")
    return all_exercises


def download_gif(gif_url, dest_path):
    """Download a GIF from URL to dest_path."""
    try:
        req = urllib.request.Request(gif_url, headers={'User-Agent': 'WorkoutApp/1.0'})
        with urllib.request.urlopen(req, timeout=20) as resp:
            data = resp.read()
        with open(dest_path, 'wb') as f:
            f.write(data)
        size_kb = len(data) / 1024
        return True, size_kb
    except Exception as e:
        return False, str(e)


def find_best_match(search_terms, all_exercises):
    """Find best matching exercise from the DB for given search terms."""
    for term in search_terms:
        term_lower = term.lower()
        # Exact name match first
        for ex in all_exercises:
            if ex['name'].lower() == term_lower:
                return ex
        # Starts with match
        for ex in all_exercises:
            if ex['name'].lower().startswith(term_lower):
                return ex
        # Contains match
        for ex in all_exercises:
            if term_lower in ex['name'].lower():
                return ex
        # All words present
        words = term_lower.split()
        if len(words) > 1:
            for ex in all_exercises:
                name = ex['name'].lower()
                if all(w in name for w in words):
                    return ex
        # Any word match (last resort)
        for word in words:
            if len(word) > 3:  # skip short words
                for ex in all_exercises:
                    if word in ex['name'].lower():
                        return ex
    return None


# ─── MAIN ─────────────────────────────────────────────────────────────────
def main():
    # Step 1: Fetch all exercises
    all_exercises = fetch_all_exercises()
    if not all_exercises:
        print("ERROR: Could not fetch exercises from API.")
        return

    # Step 2: Download GIFs
    print("=" * 60)
    print("Downloading exercise GIFs...")
    print("=" * 60)

    success_count = 0
    fail_count = 0
    failed_list = []

    for gif_filename, search_terms in EXERCISE_SEARCH_MAP.items():
        dest_path = os.path.join(OUT, gif_filename)

        # Skip if already exists and is a good size (>20KB = real GIF)
        if os.path.exists(dest_path) and os.path.getsize(dest_path) > 20000:
            print(f"⏭  SKIP (exists): {gif_filename}")
            success_count += 1
            continue

        # Find matching exercise
        match = find_best_match(search_terms, all_exercises)
        if not match:
            print(f"✗  NOT FOUND: {gif_filename} (searched: {search_terms[0]})")
            fail_count += 1
            failed_list.append(gif_filename)
            continue

        # Download GIF
        gif_url = match['gifUrl']
        matched_name = match['name']
        ok, result = download_gif(gif_url, dest_path)
        if ok:
            print(f"✓  {gif_filename:<35} ← '{matched_name}' ({result:.0f} KB)")
            success_count += 1
        else:
            print(f"✗  DOWNLOAD FAIL: {gif_filename}: {result}")
            fail_count += 1
            failed_list.append(gif_filename)

        time.sleep(0.2)  # Rate limit

    print("\n" + "=" * 60)
    print(f"DONE: {success_count} downloaded, {fail_count} failed")
    if failed_list:
        print(f"Failed GIFs (will use generated fallback): {failed_list}")
    print("=" * 60)


if __name__ == '__main__':
    main()
