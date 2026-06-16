import '../models/exercise.dart';

class ExerciseDatabase {
  static List<Exercise> get exercises {
    return [
      // ==========================================
      // CHEST (6 Exercises)
      // ==========================================
      Exercise(
        id: 'chest_pushup',
        name: 'Standard Push-Up',
        bodyPart: 'Chest',
        difficulty: 'Beginner',
        description: 'A foundational compound exercise that targets the chest, triceps, and shoulders.',
        steps: [
          'Place your hands flat on the floor, slightly wider than shoulder-width apart.',
          'Extend your legs straight back, keeping your feet together and balancing on your toes.',
          'Engage your core and glutes to keep your body in a straight line from head to heels.',
          'Lower your body by bending your elbows until your chest is just above the floor.',
          'Push through your hands to return to the starting position.'
        ],
        benefits: [
          'Builds upper-body pushing strength.',
          'Engages core stabilization muscles.',
          'Improves joint stability in shoulders and elbows.'
        ],
        mistakes: [
          'Sagging or arching the lower back.',
          'Flaring elbows out too wide (aim for a 45-degree angle).',
          'Not completing the full range of motion.'
        ],
        safetyTips: [
          'Keep your neck neutral by looking at the floor slightly in front of you.',
          'Perform on knees if standard form is too challenging.'
        ],
        duration: 45,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/standard push up.gif',
      ),
      Exercise(
        id: 'chest_wide_pushup',
        name: 'Wide-Grip Push-Up',
        bodyPart: 'Chest',
        difficulty: 'Intermediate',
        description: 'A push-up variation that places greater emphasis on the outer chest fibers.',
        steps: [
          'Assume a push-up position but place your hands significantly wider than shoulder-width.',
          'Align your body in a straight line from head to toe.',
          'Lower your chest toward the floor by bending your elbows out to the sides.',
          'Press back up, keeping the contraction in the outer chest.'
        ],
        benefits: [
          'Increases chest width activation.',
          'Reduces triceps load, placing more work on the pectorals.',
          'Enhances shoulder girdle stability.'
        ],
        mistakes: [
          'Placing hands too far forward relative to shoulders.',
          'Dropping the head instead of lowering the entire chest.'
        ],
        safetyTips: [
          'Avoid this variation if you have active shoulder injuries.',
          'Keep the movement slow and controlled.'
        ],
        duration: 45,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/wide_pushup.gif',
      ),
      Exercise(
        id: 'chest_diamond_pushup',
        name: 'Diamond Push-Up',
        bodyPart: 'Chest',
        difficulty: 'Advanced',
        description: 'An advanced push-up variant highlighting the inner chest and triceps.',
        steps: [
          'Get into a plank position and bring your index fingers and thumbs together to form a diamond shape directly under your chest.',
          'Lower your body slowly by bending your elbows close to your ribs.',
          'Push your body back up to starting position, squeezing your chest at the top.'
        ],
        benefits: [
          'Intense loading on the triceps brachii.',
          'Targets the inner chest line.',
          'Improves wrist and core stability.'
        ],
        mistakes: [
          'Flaring elbows out to the sides.',
          'Letting the hips sink to the floor.'
        ],
        safetyTips: [
          'Be mindful of wrist strain; adjust hand angle if necessary.',
          'Warm up elbows thoroughly before beginning.'
        ],
        duration: 45,
        sets: 3,
        reps: 10,
        animationPath: 'assets/gifs/diamond_pushup.gif',
      ),
      Exercise(
        id: 'chest_incline_pushup',
        name: 'Incline Push-Up',
        bodyPart: 'Chest',
        difficulty: 'Beginner',
        description: 'Using an elevated surface, this exercise targets the lower pectorals and is great for beginners.',
        steps: [
          'Place your hands on a sturdy elevated surface (chair, bench, or step).',
          'Step your feet back until your body forms a straight diagonal line.',
          'Lower your chest toward the surface, keeping elbows at 45 degrees.',
          'Press back up until your arms are fully extended.'
        ],
        benefits: [
          'Targets the lower chest region.',
          'Easier to perform than floor pushups.',
          'Excellent for building endurance.'
        ],
        mistakes: [
          'Using an unstable surface that might slip.',
          'Bending at the hips.'
        ],
        safetyTips: [
          'Ensure the bench or chair is anchored securely.',
          'Keep your shoulders depressed down away from ears.'
        ],
        duration: 40,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/incline_pushup.gif',
      ),
      Exercise(
        id: 'chest_decline_pushup',
        name: 'Decline Push-Up',
        bodyPart: 'Chest',
        difficulty: 'Advanced',
        description: 'Elevating the feet increases the load and targets the upper chest and shoulders.',
        steps: [
          'Place your feet on a chair, bench, or sofa, and your hands flat on the floor.',
          'Align your hands slightly wider than your shoulders.',
          'Lower your chest to the floor while keeping your body rigid.',
          'Press up dynamically back to the starting point.'
        ],
        benefits: [
          'Builds the upper pectoral muscles.',
          'Increases total bodyweight percentage lifted.',
          'Strengthens anterior deltoids.'
        ],
        mistakes: [
          'Looking down and letting your lower back sag.',
          'Positioning hands too far forward.'
        ],
        safetyTips: [
          'Avoid arching the spine excessively.',
          'Start with low feet elevation and increase gradually.'
        ],
        duration: 50,
        sets: 3,
        reps: 10,
        animationPath: 'assets/gifs/decline_pushup.gif',
      ),
      Exercise(
        id: 'chest_decline_chest_squeeze',
        name: 'Floor Isometric Chest Squeeze',
        bodyPart: 'Chest',
        difficulty: 'Beginner',
        description: 'An isometric drill focused on activating and contracting pectoral fibers.',
        steps: [
          'Sit or stand with a straight posture.',
          'Press the palms of your hands together in front of your chest (prayer position).',
          'Squeeze your hands together as hard as possible, focusing on contracting the chest muscles.',
          'Hold the tension for the specified duration.'
        ],
        benefits: [
          'Develops mind-muscle connection with the chest.',
          'Requires absolutely no joint movement (great for recovery).',
          'Safe and highly accessible.'
        ],
        mistakes: [
          'Holding your breath during the squeeze.',
          'Squeezing only the hands without engaging the chest.'
        ],
        safetyTips: [
          'Keep breathing deeply throughout the hold.',
          'Relax your shoulders so they do not shrug up.'
        ],
        duration: 30,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/chest_squeeze.gif',
      ),

      // ==========================================
      // BACK (6 Exercises)
      // ==========================================
      Exercise(
        id: 'back_superman',
        name: 'Superman Hold',
        bodyPart: 'Back',
        difficulty: 'Beginner',
        description: 'Strengthens the entire posterior chain, including the lower back, glutes, and hamstrings.',
        steps: [
          'Lie face down on the floor with your legs straight and arms extended overhead.',
          'Simultaneously lift your arms, chest, and legs off the floor as high as comfortable.',
          'Hold this posture, squeezing your lower back and glutes.',
          'Slowly lower yourself back to the starting position.'
        ],
        benefits: [
          'Reduces lower back pain.',
          'Improves posture and spinal alignment.',
          'Strengthens the glutes and erector spinae.'
        ],
        mistakes: [
          'Hyperextending the neck by looking up.',
          'Holding the breath during the lift.'
        ],
        safetyTips: [
          'Keep your chin tucked slightly to protect the neck.',
          'Perform a rhythmic raise-and-lower if a static hold is too intense.'
        ],
        duration: 40,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/superman.gif',
      ),
      Exercise(
        id: 'back_cobra',
        name: 'Cobra Stretch / Raise',
        bodyPart: 'Back',
        difficulty: 'Beginner',
        description: 'A gentle back extension targeting the lower back and opening the chest.',
        steps: [
          'Lie face down on the floor with your palms near your ribs, elbows tucked in close.',
          'Press your pubic bone into the floor and lift your chest off the ground.',
          'Use your back muscles primarily, using your hands only for light support.',
          'Hold at the top, feeling a stretch in your lower back and abdomen.'
        ],
        benefits: [
          'Stretches chest and abdominal muscles.',
          'Strengthens lumbar extensors.',
          'Improves thoracic mobility.'
        ],
        mistakes: [
          'Pushing up too high with the arms, pinching the lumbar spine.',
          'Letting the shoulders shrug up to the ears.'
        ],
        safetyTips: [
          'Keep your shoulders down and back.',
          'Work within a comfortable range of motion; do not push through sharp pain.'
        ],
        duration: 35,
        sets: 3,
        reps: 10,
        animationPath: 'assets/gifs/cobra.gif',
      ),
      Exercise(
        id: 'back_reverse_snow_angel',
        name: 'Reverse Snow Angel',
        bodyPart: 'Back',
        difficulty: 'Intermediate',
        description: 'An excellent mobility and endurance exercise for the upper back and shoulders.',
        steps: [
          'Lie face down on the floor, forehead resting lightly or floating just off the ground.',
          'Extend your arms out to the sides, palms down, and hover them 2 inches off the floor.',
          'Slowly sweep your arms forward until they meet above your head.',
          'Sweep them back down to your hips, rotating your thumbs outward as you do so.'
        ],
        benefits: [
          'Strengthens rhomboids and lower traps.',
          'Improves scapular control and shoulder health.',
          'Counteracts the effects of sitting at a desk.'
        ],
        mistakes: [
          'Letting arms touch the floor mid-rep.',
          'Lifting the chest too high, straining the neck.'
        ],
        safetyTips: [
          'Move slowly; focus on the squeeze between your shoulder blades.',
          'Keep the back of your neck long.'
        ],
        duration: 45,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/reverse_snow_angel.gif',
      ),
      Exercise(
        id: 'back_bird_dog',
        name: 'Bird Dog',
        bodyPart: 'Back',
        difficulty: 'Beginner',
        description: 'An exceptional core and back stabilization exercise emphasizing balance and control.',
        steps: [
          'Start on all fours with your hands under your shoulders and knees under your hips.',
          'Extend your right arm straight forward and your left leg straight backward simultaneously.',
          'Hold for a second, keeping your torso flat and level.',
          'Return to starting position and repeat with the opposite arm and leg.'
        ],
        benefits: [
          'Improves core stabilization.',
          'Relieves tension in the lower back.',
          'Enhances balance and coordination.'
        ],
        mistakes: [
          'Tilting the hips or twisting the pelvis.',
          'Lifting the leg too high, arching the back.'
        ],
        safetyTips: [
          'Keep your abdomen pulled inward to engage the core.',
          'Do not rush; complete each extension with control.'
        ],
        duration: 40,
        sets: 3,
        reps: 16,
        animationPath: 'assets/gifs/bird_dog.gif',
      ),
      Exercise(
        id: 'back_prone_y_raise',
        name: 'Prone Y-Raise',
        bodyPart: 'Back',
        difficulty: 'Intermediate',
        description: 'Isolates the lower trapezius muscles which are vital for shoulder posture.',
        steps: [
          'Lie face down on the floor with your arms extended at a 45-degree angle forming a Y shape.',
          'Point your thumbs pointing upward toward the ceiling.',
          'Keep your forehead on the floor and lift your arms off the ground as high as possible.',
          'Squeeze the lower shoulder blades and slowly lower your arms.'
        ],
        benefits: [
          'Targets the hard-to-reach lower trapezius.',
          'Improves scapular retraction.',
          'Reduces upper-shoulder tension.'
        ],
        mistakes: [
          'Lifting with the neck muscles instead of mid-back.',
          'Bending the elbows.'
        ],
        safetyTips: [
          'Keep your forehead resting on a towel roll if neck discomfort occurs.',
          'Lift using only the shoulder blades.'
        ],
        duration: 30,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/prone_y_raise.gif',
      ),
      Exercise(
        id: 'back_w_extension',
        name: 'Prone W-Extensions',
        bodyPart: 'Back',
        difficulty: 'Intermediate',
        description: 'Activates the rhomboids and middle traps to improve pulling posture.',
        steps: [
          'Lie face down on the floor.',
          'Bend your elbows and pull them down towards your ribs, forming a W shape with your arms.',
          'Hover your arms and chest slightly off the ground.',
          'Pinch your shoulder blades back and down tightly, hold for 2 seconds, and release.'
        ],
        benefits: [
          'Builds mid-back endurance.',
          'Relieves shoulder tightness.',
          'Assists with posture correction.'
        ],
        mistakes: [
          'Shrugging shoulders upward.',
          'Over-arching the neck.'
        ],
        safetyTips: [
          'Keep your gaze downward to maintain neck safety.',
          'Ensure the movement comes from shoulder blade retraction.'
        ],
        duration: 35,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/prone_w_extension.gif',
      ),

      // ==========================================
      // LEGS (8 Exercises)
      // ==========================================
      Exercise(
        id: 'legs_bodyweight_squat',
        name: 'Bodyweight Squat',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'The fundamental leg exercise targeting the quadriceps, glutes, and hamstrings.',
        steps: [
          'Stand with feet shoulder-width apart, toes pointed slightly outward.',
          'Inhale and lower your hips by bending your knees and pushing your hips back as if sitting in a chair.',
          'Keep your chest upright and your back flat, knees tracking over your toes.',
          'Lower down until thighs are parallel to the floor.',
          'Exhale and push through your heels to return to standing.'
        ],
        benefits: [
          'Builds lower body strength and mobility.',
          'Improves hip, knee, and ankle flexibility.',
          'Burns calories effectively due to massive muscle involvement.'
        ],
        mistakes: [
          'Letting the knees cave inward.',
          'Lifting the heels off the floor.',
          'Rounding the spine at the bottom.'
        ],
        safetyTips: [
          'Keep weight distributed evenly on your heels and mid-foot.',
          'Do not go past parallel if you experience knee pain.'
        ],
        duration: 50,
        sets: 3,
        reps: 20,
        animationPath: 'assets/gifs/squat.gif',
      ),
      Exercise(
        id: 'legs_sumo_squat',
        name: 'Sumo Squat',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'A wide-stance squat variation focusing on the inner thighs (adductors) and glutes.',
        steps: [
          'Stand with feet wider than shoulder-width, toes turned outward at a 45-degree angle.',
          'Lower your hips downward, keeping your chest tall and knees pointing in the direction of your toes.',
          'Descend until thighs are parallel to the floor, feeling the stretch in the groin.',
          'Press back up, squeezing the glutes at the top.'
        ],
        benefits: [
          'Emphasizes inner thighs (adductors).',
          'Strong gluteus maximus recruitment.',
          'Increases hip opening range of motion.'
        ],
        mistakes: [
          'Letting the knees collapse forward instead of pushing out.',
          'Leaning too far forward.'
        ],
        safetyTips: [
          'Focus on driving your knees outward as you lower.',
          'Only squat as low as your flexibility allows.'
        ],
        duration: 40,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/sumo_squat.gif',
      ),
      Exercise(
        id: 'legs_forward_lunge',
        name: 'Forward Lunge',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'Unilateral leg exercise that develops balance, coordination, and single-leg strength.',
        steps: [
          'Stand tall with your feet hip-width apart.',
          'Take a large step forward with your right foot.',
          'Lower your hips until your back knee is hovering just off the floor, and front knee is at 90 degrees.',
          'Push through your front heel to step back to the starting stance.',
          'Repeat on the opposite side.'
        ],
        benefits: [
          'Addresses muscle imbalances between legs.',
          'Develops stability and balance.',
          'Strengthens thighs, glutes, and calves.'
        ],
        mistakes: [
          'Letting the front knee overshoot the front toes.',
          'Losing balance due to stepping in a straight line (think train tracks, not a tightrope).'
        ],
        safetyTips: [
          'Keep your torso upright throughout the lunge.',
          'Take smaller steps if you feel knee discomfort.'
        ],
        duration: 45,
        sets: 3,
        reps: 16,
        animationPath: 'assets/gifs/lunge.gif',
      ),
      Exercise(
        id: 'legs_reverse_lunge',
        name: 'Reverse Lunge',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'A lunge variation that is generally friendlier to the knees while emphasizing the glutes.',
        steps: [
          'Stand with feet hip-width apart.',
          'Step backward with your left foot.',
          'Lower your hips until your back knee is just above the floor, and front thigh is parallel to the ground.',
          'Push off your back foot and drive your front heel down to stand back up.',
          'Switch sides.'
        ],
        benefits: [
          'Reduced knee joint strain compared to forward lunges.',
          'Strong focus on the hamstrings and glutes.',
          'Improves athletic backward movement control.'
        ],
        mistakes: [
          'Leaning too far forward, overloading the quad.',
          'Allowing the front knee to wobble.'
        ],
        safetyTips: [
          'Step back far enough so your front knee remains behind your toes.',
          'Engage the core to steady your balance.'
        ],
        duration: 40,
        sets: 3,
        reps: 16,
        animationPath: 'assets/gifs/reverse_lunge.gif',
      ),
      Exercise(
        id: 'legs_glute_bridge',
        name: 'Glute Bridge',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'Excellent isolation exercise for the glutes and hamstrings, while resting the spine.',
        steps: [
          'Lie on your back with knees bent and feet flat on the floor, hip-width apart.',
          'Place arms by your side, palms flat.',
          'Squeeze your glutes and push through your heels to raise your hips towards the ceiling.',
          'Create a straight line from knees to shoulders, hold for 1 second, then lower slowly.'
        ],
        benefits: [
          'Isolates and activates the gluteal muscles.',
          'Relieves lower back compression.',
          'Stretches hip flexors.'
        ],
        mistakes: [
          'Arching the lower back excessively at the top (keep ribs down).',
          'Pushing off the toes rather than the heels.'
        ],
        safetyTips: [
          'Only lift your hips until they align with your knees and shoulders.',
          'Squeeze glutes actively at the top rather than just lifting passively.'
        ],
        duration: 35,
        sets: 3,
        reps: 18,
        animationPath: 'assets/gifs/glute_bridge.gif',
      ),
      Exercise(
        id: 'legs_calf_raise',
        name: 'Standing Calf Raise',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'Builds size, strength, and endurance in the gastrocnemius and soleus calf muscles.',
        steps: [
          'Stand straight with feet hip-width apart (hold a wall or sturdy surface for balance).',
          'Slowly raise up onto the balls of your feet, lifting your heels off the ground.',
          'Squeeze the calf muscles at the highest point.',
          'Lower your heels back down in a slow, controlled motion.'
        ],
        benefits: [
          'Improves ankle joint strength.',
          'Increases vertical jump performance.',
          'Improves calf muscle aesthetics and strength.'
        ],
        mistakes: [
          'Bending knees (this turns it into a squat variant).',
          'Bouncing too fast, using momentum.'
        ],
        safetyTips: [
          'Focus on a slow 3-second descent for maximum hypertrophy benefits.',
          'If possible, perform on the edge of a step to increase range of motion.'
        ],
        duration: 30,
        sets: 3,
        reps: 25,
        animationPath: 'assets/gifs/calf_raise.gif',
      ),
      Exercise(
        id: 'legs_wall_sit',
        name: 'Isometric Wall Sit',
        bodyPart: 'Legs',
        difficulty: 'Beginner',
        description: 'A static hold that builds muscular endurance in the quadriceps.',
        steps: [
          'Stand with your back against a wall.',
          'Slide down the wall until your knees are bent at a 90-degree angle, thighs parallel to the floor.',
          'Ensure your knees are directly above your ankles.',
          'Keep your back flat against the wall and hold the position.'
        ],
        benefits: [
          'Builds massive isometric endurance in the legs.',
          'Low joint impact while maintaining high muscle recruitment.',
          'Mentally challenging.'
        ],
        mistakes: [
          'Letting hips rest higher or lower than 90 degrees.',
          'Resting hands on the thighs (keep them crossed or down).'
        ],
        safetyTips: [
          'Wear shoes with good grip so your feet do not slip.',
          'Exit the hold if you feel sharp pain in the knee caps.'
        ],
        duration: 40,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/wall_sit.gif',
      ),
      Exercise(
        id: 'legs_bulgarian_split_squat',
        name: 'Bulgarian Split Squat',
        bodyPart: 'Legs',
        difficulty: 'Advanced',
        description: 'An advanced single-leg squat that isolates the front quad and glute.',
        steps: [
          'Stand 2 feet in front of a chair or sofa, facing away.',
          'Reach one foot backward and rest the top of your foot on the elevated surface.',
          'Keep your chest high and bend your front knee to lower your hips towards the ground.',
          'Descend until the front thigh is parallel to the ground, then push back up.'
        ],
        benefits: [
          'Extreme unilateral strength developer.',
          'Stretches the back leg hip flexor intensely.',
          'Improves dynamic balance.'
        ],
        mistakes: [
          'Letting front knee collapse inwards.',
          'Front foot placed too close, compressing the knee.'
        ],
        safetyTips: [
          'Make sure the chair is stable.',
          'Focus on a spot in front of you to maintain stability.'
        ],
        duration: 50,
        sets: 3,
        reps: 10,
        animationPath: 'assets/gifs/bulgarian_split_squat.gif',
      ),

      // ==========================================
      // SHOULDERS (6 Exercises)
      // ==========================================
      Exercise(
        id: 'shoulders_pike_pushup',
        name: 'Pike Push-Up',
        bodyPart: 'Shoulders',
        difficulty: 'Advanced',
        description: 'A bodyweight vertical push that targets the anterior and lateral deltoids.',
        steps: [
          'Begin in a push-up position, then walk your feet forward and lift your hips to form a downward V-shape (downward dog).',
          'Keep your legs straight and look at your feet to keep your spine aligned.',
          'Bend your elbows and lower the top of your head toward the floor between your hands.',
          'Push through your palms to return to the starting position.'
        ],
        benefits: [
          'Great bodyweight overhead press alternative.',
          'Strengthens the shoulders and upper chest.',
          'Improves shoulder mobility and core control.'
        ],
        mistakes: [
          'Lowering the head flat between hands instead of creating a tripod head-hand triangle.',
          'Flaring elbows out horizontally.'
        ],
        safetyTips: [
          'Ensure your hands have a solid grip on the floor.',
          'Stop before your head touches the floor to avoid spinal impact.'
        ],
        duration: 45,
        sets: 3,
        reps: 8,
        animationPath: 'assets/gifs/pike_pushup.gif',
      ),
      Exercise(
        id: 'shoulders_arm_circle',
        name: 'Arm Circles',
        bodyPart: 'Shoulders',
        difficulty: 'Beginner',
        description: 'A low-intensity warm-up that builds muscular endurance in the deltoids.',
        steps: [
          'Stand tall with feet shoulder-width apart.',
          'Extend your arms out to the sides at shoulder height, parallel to the floor.',
          'Make small, controlled circular motions in a forward direction.',
          'Reverse direction after the specified reps or time.'
        ],
        benefits: [
          'Warms up the rotator cuff joints.',
          'Increases blood flow to the shoulders.',
          'Builds shoulder lateral head endurance.'
        ],
        mistakes: [
          'Dropping the arms below shoulder level.',
          'Moving too fast with wild, uncontrolled motions.'
        ],
        safetyTips: [
          'Keep your shoulders rolled back and down.',
          'Breathe deeply and keep core locked.'
        ],
        duration: 30,
        sets: 3,
        reps: 30,
        animationPath: 'assets/gifs/6c1a4598-1177-11ee-9e88-bf9e8c56d70c.gif', // Fallback as arm_circles.gif is missing
      ),
      Exercise(
        id: 'shoulders_plank_tap',
        name: 'Plank Shoulder Taps',
        bodyPart: 'Shoulders',
        difficulty: 'Intermediate',
        description: 'Targets shoulder stability and core stabilization under anti-rotation stress.',
        steps: [
          'Assume a high plank position with hands directly under shoulders.',
          'Set feet slightly wider than normal to assist stability.',
          'Lift your right hand and tap your left shoulder, keeping your hips as still as possible.',
          'Lower your right hand, then lift your left hand and tap your right shoulder.'
        ],
        benefits: [
          'Builds shoulder weight-bearing strength.',
          'Increases transverse core stability.',
          'Improves coordination and balance.'
        ],
        mistakes: [
          'Rocking hips side to side (keep them parallel to the floor).',
          'Placing hands too far forward.'
        ],
        safetyTips: [
          'Squeeze your glutes and pull your navel in to limit hip sway.',
          'Keep your shoulders stacked over your wrists.'
        ],
        duration: 40,
        sets: 3,
        reps: 20,
        animationPath: 'assets/gifs/plank.gif', // Fallback to plank
      ),
      Exercise(
        id: 'shoulders_t_raise',
        name: 'Prone T-Raise',
        bodyPart: 'Shoulders',
        difficulty: 'Intermediate',
        description: 'Focuses on the posterior deltoid, improving rear shoulder thickness and posture.',
        steps: [
          'Lie face down on the floor with arms out to the sides, forming a T shape.',
          'Rotate your wrists so your thumbs point up towards the ceiling.',
          'Pinch your shoulder blades and lift your arms up as high as possible.',
          'Hold for 1 second, then slowly lower to the floor.'
        ],
        benefits: [
          'Targets the rear delts and mid back.',
          'Counteracts rounded shoulder posture.',
          'Assists in healthy shoulder biomechanics.'
        ],
        mistakes: [
          'Bending at the elbows.',
          'Shrugging shoulders up towards ears.'
        ],
        safetyTips: [
          'Do not use quick, jerky movements; lift under control.',
          'Keep your forehead resting on the floor.'
        ],
        duration: 30,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/prone_y_raise.gif', // Partial fallback
      ),
      Exercise(
        id: 'shoulders_y_raise_wall',
        name: 'Wall Slide Y-Extension',
        bodyPart: 'Shoulders',
        difficulty: 'Beginner',
        description: 'Excellent rehabilitation and posture exercise utilizing wall feedback.',
        steps: [
          'Stand with your heels, glutes, upper back, and head flat against a wall.',
          'Raise your arms up and press your elbows, wrists, and backs of your hands against the wall.',
          'Slowly slide your arms upward, maintaining contact with the wall, forming a Y shape.',
          'Slide back down to shoulder level, squeezing the upper back.'
        ],
        benefits: [
          'Fosters excellent upper body alignment.',
          'Opens chest and activates rear shoulder fibers.',
          'Safe for all fitness levels.'
        ],
        mistakes: [
          'Lifting the lower back off the wall.',
          'Letting the hands or elbows float off the wall.'
        ],
        safetyTips: [
          'Keep your tailbone and shoulder blades locked to the wall.',
          'Only slide as high as you can maintain full contact.'
        ],
        duration: 40,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/prone_y_raise.gif', // Partial fallback
      ),
      Exercise(
        id: 'shoulders_inchworm_press',
        name: 'Inchworm to Pike Push-Up',
        bodyPart: 'Shoulders',
        difficulty: 'Advanced',
        description: 'Combines dynamic flexibility with shoulder loading and stability.',
        steps: [
          'Stand with feet hip-width apart.',
          'Fold at your hips and place your hands on the floor in front of you.',
          'Walk your hands forward into a high plank position, then immediately push hips up and walk feet halfway forward into a pike position.',
          'Perform one pike push-up, then walk your hands back to your feet and stand up.'
        ],
        benefits: [
          'Dynamic full-body coordination.',
          'Develops hamstring flexibility.',
          'Intense upper body workout.'
        ],
        mistakes: [
          'Allowing hips to drop too low, causing back strain.',
          'Bending knees too much.'
        ],
        safetyTips: [
          'Move step-by-step; do not rush the walking motion.',
          'Stop if you feel lightheaded in the inverted position.'
        ],
        duration: 50,
        sets: 3,
        reps: 6,
        animationPath: 'assets/gifs/pike_pushup.gif',
      ),

      // ==========================================
      // ARMS (6 Exercises)
      // ==========================================
      Exercise(
        id: 'arms_bench_dip',
        name: 'Bench Dips',
        bodyPart: 'Arms',
        difficulty: 'Beginner',
        description: 'A simple and effective triceps exercise using a stable chair or step.',
        steps: [
          'Sit on the edge of a sturdy chair or bench, hands next to your hips.',
          'Slide your glutes off the edge of the seat, supporting your weight with your arms.',
          'Bend your elbows to lower your hips toward the floor until your upper arms are parallel to the ground.',
          'Press through your palms to return to the starting position.'
        ],
        benefits: [
          'Isolates the triceps muscle.',
          'Can be performed anywhere with a chair.',
          'Strengthens the anterior deltoids and chest.'
        ],
        mistakes: [
          'Letting your hips drift too far forward from the bench (keep them close).',
          'Lowering too deep, putting excessive strain on the shoulder joints.'
        ],
        safetyTips: [
          'Keep your elbows pointing directly behind you, not flaring out.',
          'Rest your feet closer (knees bent) to make it easier, or extend legs out to make it harder.'
        ],
        duration: 40,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/6c1a4598-1177-11ee-9e88-bf9e8c56d70c.gif', // Fallback
      ),
      Exercise(
        id: 'arms_towel_curl',
        name: 'Towel Isometric Bicep Curl',
        bodyPart: 'Arms',
        difficulty: 'Beginner',
        description: 'A creative isometric pull that targets the biceps without weights.',
        steps: [
          'Stand in the middle of a long towel or bed sheet with both feet.',
          'Grab the ends of the towel with each hand, palms facing up.',
          'Bend your elbows at 90 degrees and pull upward on the towel as hard as possible.',
          'Maintain maximum pull and tension throughout the exercise.'
        ],
        benefits: [
          'Generates strong bicep hypertrophy tension without joint impact.',
          'Enhances forearm and grip strength.',
          'Teaches high-intensity muscle contraction.'
        ],
        mistakes: [
          'Rounding the lower back.',
          'Relaxing the tension mid-set.'
        ],
        safetyTips: [
          'Keep your spine tall and core braced.',
          'Keep breathing; do not hold your breath during the pull.'
        ],
        duration: 30,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/chest_squeeze.gif', // Fallback
      ),
      Exercise(
        id: 'arms_chaturanga_hold',
        name: 'Chaturanga Low Plank Hold',
        bodyPart: 'Arms',
        difficulty: 'Advanced',
        description: 'A yoga posture that builds incredible triceps and core static endurance.',
        steps: [
          'Start in a high plank position.',
          'Lower your body down until your elbows are at 90 degrees, tucked tightly against your rib cage.',
          'Hover your chest and abdomen just above the floor in a straight line.',
          'Hold this low position for the target time.'
        ],
        benefits: [
          'Intense development of triceps and core strength.',
          'Strengthens wrist flexors.',
          'Improves overall body control.'
        ],
        mistakes: [
          'Letting elbows flare outwards.',
          'Letting the belly or hips sag to the ground.'
        ],
        safetyTips: [
          'If too intense, drop your knees to the ground to keep proper form.',
          'Avoid if you have wrist or shoulder issues.'
        ],
        duration: 35,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/plank.gif', // Fallback
      ),
      Exercise(
        id: 'arms_tricep_kickback_body',
        name: 'Bodyweight Triceps Kickbacks',
        bodyPart: 'Arms',
        difficulty: 'Beginner',
        description: 'An isometric and active mobility movement focusing on elbow extension.',
        steps: [
          'Hinge forward at your hips, keeping your back flat.',
          'Bring your elbows up high next to your ribcage.',
          'Extend your arms completely behind you, palms facing up.',
          'Hold and squeeze the triceps at the peak for 2 seconds before returning.'
        ],
        benefits: [
          'Develops mid-back and triceps mind-muscle connection.',
          'No joint strain or compression.',
          'Great for beginners to learn kickback movement patterns.'
        ],
        mistakes: [
          'Swinging the elbows (keep them pinned in place).',
          'Rounding the shoulders forward.'
        ],
        safetyTips: [
          'Ensure your knees are slightly bent to protect your back.',
          'Maintain a flat spine throughout the hinge.'
        ],
        duration: 30,
        sets: 3,
        reps: 15,
        animationPath: 'assets/gifs/prone_w_extension.gif', // Fallback
      ),
      Exercise(
        id: 'arms_doorway_curl',
        name: 'Doorframe Bicep Pulls',
        bodyPart: 'Arms',
        difficulty: 'Intermediate',
        description: 'Uses a doorframe to perform a bodyweight rowing motion that isolates the biceps.',
        steps: [
          'Stand facing the edge of a doorframe, feet close to the base.',
          'Grasp the doorframe with one hand at chest level.',
          'Lean back fully until your arm is straight, feet acting as a pivot point.',
          'Use your bicep to pull your chest back towards the frame in a curling motion.'
        ],
        benefits: [
          'Excellent single-arm bicep workout without equipment.',
          'Strengthens finger grip and forearm muscles.',
          'Customizable difficulty (lean further for more resistance).'
        ],
        mistakes: [
          'Pulling with the back muscles primarily (keep focus on the elbow flexor).',
          'Slipping feet.'
        ],
        safetyTips: [
          'Ensure the doorframe is sturdy and secure.',
          'Hold with a firm grip to prevent slips.'
        ],
        duration: 40,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/chest_squeeze.gif', // Fallback
      ),
      Exercise(
        id: 'arms_punches',
        name: 'Shadow Boxing Punches',
        bodyPart: 'Arms',
        difficulty: 'Beginner',
        description: 'A dynamic cardio and arm muscle-endurance exercise.',
        steps: [
          'Stand in a boxing stance with your hands up guarding your face.',
          'Extend your left hand forward in a straight punch (jab), rotating the wrist.',
          'Pull it back and immediately throw a straight right punch (cross).',
          'Maintain a fast, rhythmic pace, breathing out with each punch.'
        ],
        benefits: [
          'Burns calories while building shoulder and arm endurance.',
          'Relieves stress and improves reflexes.',
          'Engages core rotation.'
        ],
        mistakes: [
          'Hyperextending and locking out the elbows on impact (keep a slight bend).',
          'Dropping the guarding hand.'
        ],
        safetyTips: [
          'Do not throw punches with absolute force to avoid elbow hyperextension.',
          'Keep knees soft and loose.'
        ],
        duration: 45,
        sets: 3,
        reps: 50,
        animationPath: 'assets/gifs/6c1a4598-1177-11ee-9e88-bf9e8c56d70c.gif', // Fallback
      ),

      // ==========================================
      // ABS (6 Exercises)
      // ==========================================
      Exercise(
        id: 'abs_crunch',
        name: 'Abdominal Crunch',
        bodyPart: 'Abs',
        difficulty: 'Beginner',
        description: 'The standard core exercise for isolating the rectus abdominis.',
        steps: [
          'Lie on your back with knees bent and feet flat on the floor.',
          'Place hands lightly behind your head, elbows wide.',
          'Contract your abs and lift your shoulder blades off the floor, exhaling as you rise.',
          'Slowly lower back down to the starting position.'
        ],
        benefits: [
          'Targets the upper abdominal region.',
          'Low complexity, highly accessible.',
          'Strengthens the abdominal wall.'
        ],
        mistakes: [
          'Pulling the neck forward with hands (hands should only support).',
          'Lifting the lower back off the floor (this is not a full sit-up).'
        ],
        safetyTips: [
          'Keep your chin tucked slightly, as if holding an orange under it.',
          'Press your lower back firmly into the floor.'
        ],
        duration: 35,
        sets: 3,
        reps: 20,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
      Exercise(
        id: 'abs_bicycle',
        name: 'Bicycle Crunch',
        bodyPart: 'Abs',
        difficulty: 'Intermediate',
        description: 'Targets both the obliques and rectus abdominis in a twisting motion.',
        steps: [
          'Lie on your back, lift your knees to 90 degrees, and hands behind head.',
          'Raise your shoulder blades off the floor.',
          'Extend your right leg straight while twisting your torso to bring your right elbow toward your left knee.',
          'Switch sides, extending the left leg and bringing the left elbow toward the right knee.'
        ],
        benefits: [
          'Ranked as one of the best overall exercises for abdominal activation.',
          'Trains abdominal rotation and coordination.',
          'Builds lower and upper abs simultaneously.'
        ],
        mistakes: [
          'Rushing through reps (slower is much harder and safer).',
          'Tucking the chin aggressively.'
        ],
        safetyTips: [
          'Extend the non-working leg higher to make it easier, or closer to the floor to make it harder.',
          'Keep shoulder blades elevated throughout.'
        ],
        duration: 45,
        sets: 3,
        reps: 20,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
      Exercise(
        id: 'abs_russian_twist',
        name: 'Russian Twist',
        bodyPart: 'Abs',
        difficulty: 'Intermediate',
        description: 'Develops rotational core strength, targeting the internal and external obliques.',
        steps: [
          'Sit on the floor with your knees bent, heels touching the ground.',
          'Lean back slightly at a 45-degree angle, keeping your spine straight.',
          'Clasp your hands in front of you.',
          'Twist your torso to the right, tapping your hands on the floor, then twist to the left.',
          'Lift feet off the ground for an advanced challenge.'
        ],
        benefits: [
          'Targets obliques and side core strength.',
          'Improves spinal rotation flexibility.',
          'Enhances balance.'
        ],
        mistakes: [
          'Rounding the back (keep chest up and back flat).',
          'Moving only the arms instead of rotating the whole torso.'
        ],
        safetyTips: [
          'If your lower back begins to ache, place feet back flat on the ground.',
          'Keep the movement slow and controlled.'
        ],
        duration: 40,
        sets: 3,
        reps: 20,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
      Exercise(
        id: 'abs_leg_raise',
        name: 'Lying Leg Raise',
        bodyPart: 'Abs',
        difficulty: 'Intermediate',
        description: 'A powerful exercise targeting the lower abdominals and hip flexors.',
        steps: [
          'Lie flat on your back with legs straight, hands under your glutes for support.',
          'Keep your legs together and slowly lift them until they point to the ceiling.',
          'Slowly lower your legs back down until they are 2 inches off the ground.',
          'Raise them back up immediately, keeping core contracted.'
        ],
        benefits: [
          'Isolates the lower rectus abdominis.',
          'Builds hip flexor strength.',
          'Improves lower back stability.'
        ],
        mistakes: [
          'Allowing the lower back to arch away from the floor (keep it glued).',
          'Dropping the legs too fast.'
        ],
        safetyTips: [
          'If you cannot keep your lower back flat, bend your knees slightly.',
          'Do not let feet touch the floor between reps.'
        ],
        duration: 40,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
      Exercise(
        id: 'abs_flutter_kick',
        name: 'Flutter Kicks',
        bodyPart: 'Abs',
        difficulty: 'Intermediate',
        description: 'An endurance exercise that keeps the lower abs under constant tension.',
        steps: [
          'Lie on your back, hands under your hips, head and shoulders slightly raised.',
          'Lift your legs 6 inches off the floor.',
          'Alternatingly raise and lower each leg a few inches in a fluttering motion.',
          'Maintain tight abs and keep lower back flat on the floor.'
        ],
        benefits: [
          'Great for lower abdominal definition.',
          'Increases core muscular endurance.',
          'Engages hip flexor muscles.'
        ],
        mistakes: [
          'Lifting legs too high (this reduces tension).',
          'Arching the spine.'
        ],
        safetyTips: [
          'Look at your toes to help naturally flatten the lower back.',
          'Rest if you feel strain in the lower spine.'
        ],
        duration: 35,
        sets: 3,
        reps: 30,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
      Exercise(
        id: 'abs_v_up',
        name: 'V-Up',
        bodyPart: 'Abs',
        difficulty: 'Advanced',
        description: 'An advanced core exercise requiring strength, balance, and coordination.',
        steps: [
          'Lie flat on your back with arms extended overhead and legs straight.',
          'Exhale and contract your abs, lifting your legs and torso off the floor simultaneously.',
          'Reach your hands toward your feet, forming a V-shape with your body.',
          'Inhale and slowly lower your body back to the starting position.'
        ],
        benefits: [
          'Works the upper and lower abs in unison.',
          'Improves balance and spinal control.',
          'High calorie burn.'
        ],
        mistakes: [
          'Using excessive momentum to throw the arms forward.',
          'Bending the knees too much.'
        ],
        safetyTips: [
          'Keep your descent slow to protect the tailbone.',
          'If too difficult, perform a tuck-up (bending knees to chest).'
        ],
        duration: 45,
        sets: 3,
        reps: 10,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),

      // ==========================================
      // CORE (6 Exercises)
      // ==========================================
      Exercise(
        id: 'core_plank',
        name: 'Forearm Plank',
        bodyPart: 'Core',
        difficulty: 'Beginner',
        description: 'The ultimate static core exercise that trains full-body structural stiffness.',
        steps: [
          'Place your forearms on the floor, elbows directly under your shoulders.',
          'Extend your legs straight back, balancing on your toes.',
          'Keep your neck neutral and align your body in a straight line from head to heels.',
          'Pull your belly button toward your spine and squeeze your glutes.',
          'Hold this position without letting your hips drop.'
        ],
        benefits: [
          'Strengthens the deep core muscles (transversus abdominis).',
          'Reduces back pain and improves posture.',
          'Builds shoulder static strength.'
        ],
        mistakes: [
          'Letting the hips sag or hiking them up in the air.',
          'Clasping hands together, which forces shoulders forward (keep forearms parallel).'
        ],
        safetyTips: [
          'Squeeze your thighs to take weight off the back.',
          'If your back starts to ache, drop to your knees.'
        ],
        duration: 60,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/plank.gif',
      ),
      Exercise(
        id: 'core_side_plank_left',
        name: 'Side Plank (Left)',
        bodyPart: 'Core',
        difficulty: 'Intermediate',
        description: 'Isolates the left obliques and lateral core stabilizers.',
        steps: [
          'Lie on your left side with your legs straight and feet stacked.',
          'Prop your upper body up on your left elbow, which should be directly below your shoulder.',
          'Lift your hips off the ground to form a straight diagonal line from head to feet.',
          'Extend your right arm toward the ceiling or keep it on your hip.'
        ],
        benefits: [
          'Isolates the left lateral core and obliques.',
          'Improves lateral hip stability (gluteus medius).',
          'Relieves asymmetrical spine pressure.'
        ],
        mistakes: [
          'Letting the hips dip towards the floor.',
          'Rolling the chest forward (keep it open and sideways).'
        ],
        safetyTips: [
          'Perform with knees bent at 90 degrees if full stance is too strenuous.',
          'Ensure elbow is directly under the shoulder joint.'
        ],
        duration: 40,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/plank.gif', // Fallback
      ),
      Exercise(
        id: 'core_side_plank_right',
        name: 'Side Plank (Right)',
        bodyPart: 'Core',
        difficulty: 'Intermediate',
        description: 'Isolates the right obliques and lateral core stabilizers.',
        steps: [
          'Lie on your right side with your legs straight and feet stacked.',
          'Prop your upper body up on your right elbow, which should be directly below your shoulder.',
          'Lift your hips off the ground to form a straight diagonal line from head to feet.',
          'Extend your left arm toward the ceiling or keep it on your hip.'
        ],
        benefits: [
          'Isolates the right lateral core and obliques.',
          'Improves lateral hip stability.',
          'Balances core symmetry.'
        ],
        mistakes: [
          'Letting hips drop.',
          'Allowing shoulder to collapse inwards.'
        ],
        safetyTips: [
          'Drop to knees if balance is unstable.',
          'Keep your neck aligned with your spine.'
        ],
        duration: 40,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/plank.gif', // Fallback
      ),
      Exercise(
        id: 'core_dead_bug',
        name: 'Dead Bug',
        bodyPart: 'Core',
        difficulty: 'Beginner',
        description: 'A safe, back-friendly core stability exercise that teaches coordination.',
        steps: [
          'Lie on your back with arms pointing straight up, and knees bent at 90 degrees (tabletop position).',
          'Slowly lower your right arm behind your head while extending your left leg straight forward.',
          'Hover both just above the floor, keeping your lower back pressed into the floor.',
          'Return to the starting position and repeat with your left arm and right leg.'
        ],
        benefits: [
          'Teaches core bracing during limb movement.',
          'Extremely safe for the lower back.',
          'Enhances contralateral coordination.'
        ],
        mistakes: [
          'Lower back arching off the floor.',
          'Moving too fast, losing control.'
        ],
        safetyTips: [
          'Focus 100% on keeping your lower back glued to the floor.',
          'Breathe out as you extend your limbs.'
        ],
        duration: 40,
        sets: 3,
        reps: 12,
        animationPath: 'assets/gifs/bird_dog.gif', // Fallback
      ),
      Exercise(
        id: 'core_hollow_body',
        name: 'Hollow Body Hold',
        bodyPart: 'Core',
        difficulty: 'Advanced',
        description: 'A gymnastics standard that creates intense anterior core strength.',
        steps: [
          'Lie on your back with arms extended overhead and legs straight.',
          'Contract your abs to press your lower back flat into the ground.',
          'Lift your shoulder blades and legs a few inches off the floor.',
          'Keep your arms next to your ears and hold this banana-like shape.'
        ],
        benefits: [
          'Develops extreme abdominal compression power.',
          'Translates directly to advanced movements like handstands.',
          'Builds postural control.'
        ],
        mistakes: [
          'Lower back lifting (if this happens, lift your legs higher).',
          'Holding your breath.'
        ],
        safetyTips: [
          'Raise legs higher if you cannot maintain lower back contact with the floor.',
          'Perform with arms by your sides for an easier progression.'
        ],
        duration: 30,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/superman.gif', // Fallback
      ),
      Exercise(
        id: 'core_plank_rotations',
        name: 'Plank with Hip Twists',
        bodyPart: 'Core',
        difficulty: 'Intermediate',
        description: 'Adds dynamic rotational element to the forearm plank.',
        steps: [
          'Assume a forearm plank position.',
          'Rotate your hips to the right, lowering them until they almost touch the floor.',
          'Return to center, then rotate your hips to the left.',
          'Repeat in a slow, sweeping motion.'
        ],
        benefits: [
          'Combines isometric holds with oblique activation.',
          'Improves rotational mobility of the spine.',
          'Tones waistline.'
        ],
        mistakes: [
          'Letting the elbows slide out of position.',
          'Moving too quickly and losing core alignment.'
        ],
        safetyTips: [
          'Keep your shoulders stable and parallel; rotate only from the waist down.',
          'Engage the abs to prevent back strain.'
        ],
        duration: 45,
        sets: 3,
        reps: 20,
        animationPath: 'assets/gifs/plank.gif', // Fallback
      ),

      // ==========================================
      // FULL BODY (5 Exercises)
      // ==========================================
      Exercise(
        id: 'full_jumping_jack',
        name: 'Jumping Jacks',
        bodyPart: 'Full Body',
        difficulty: 'Beginner',
        description: 'A classic cardiovascular exercise that warms up the entire body.',
        steps: [
          'Stand straight with feet together, arms by your sides.',
          'Jump your feet out to the sides while raising your arms above your head.',
          'Jump back to the starting position, lowering your arms.',
          'Maintain a quick, steady tempo.'
        ],
        benefits: [
          'Improves cardiovascular endurance.',
          'Warms up all major joint systems.',
          'Enhances coordination and agility.'
        ],
        mistakes: [
          'Landing heavily on flat feet (land soft on the balls of feet).',
          'Not bringing arms all the way up.'
        ],
        safetyTips: [
          'Keep knees slightly bent to absorb impact.',
          'If high impact hurts, step out one foot at a time instead of jumping.'
        ],
        duration: 60,
        sets: 3,
        reps: 40,
        animationPath: 'assets/gifs/jumping jack.gif',
      ),
      Exercise(
        id: 'full_burpee',
        name: 'Classic Burpee',
        bodyPart: 'Full Body',
        difficulty: 'Advanced',
        description: 'An intense full-body exercise combining a squat, jump, and push-up.',
        steps: [
          'Stand tall, then drop into a squat and place your hands on the floor.',
          'Jump your feet back to land in a high plank position.',
          'Perform a push-up (optional but recommended).',
          'Jump your feet back to your hands, then leap dynamically into the air, reaching your arms overhead.'
        ],
        benefits: [
          'High-intensity calorie burner.',
          'Combines strength, endurance, and power.',
          'Improves anaerobic threshold.'
        ],
        mistakes: [
          'Landing with locked knees.',
          'Letting the lower back sag when jumping into plank.'
        ],
        safetyTips: [
          'Land softly on your feet during the jump.',
          'Step back instead of jumping back if you need a lower impact variation.'
        ],
        duration: 50,
        sets: 3,
        reps: 10,
        animationPath: 'assets/gifs/6c1a4598-1177-11ee-9e88-bf9e8c56d70c.gif', // Fallback
      ),
      Exercise(
        id: 'full_mountain_climber',
        name: 'Mountain Climbers',
        bodyPart: 'Full Body',
        difficulty: 'Intermediate',
        description: 'A dynamic plank variation that challenges the core, legs, and cardiovascular system.',
        steps: [
          'Start in a high plank position, hands directly below shoulders.',
          'Drive your right knee toward your chest as fast as possible.',
          'Extend it back while simultaneously driving your left knee toward your chest.',
          'Repeat in a rapid, running motion, keeping your hips low.'
        ],
        benefits: [
          'Excellent core and hip flexor workout.',
          'Boosts heart rate quickly.',
          'Builds shoulder endurance.'
        ],
        mistakes: [
          'Bouncing hips too high into the air.',
          'Not bringing knees fully forward.'
        ],
        safetyTips: [
          'Keep your shoulders stacked over wrists; do not lean back.',
          'Engage the core to prevent the spine from twisting excessively.'
        ],
        duration: 45,
        sets: 3,
        reps: 40,
        animationPath: 'assets/gifs/plank.gif', // Fallback
      ),
      Exercise(
        id: 'full_high_knees',
        name: 'High Knees',
        bodyPart: 'Full Body',
        difficulty: 'Intermediate',
        description: 'A high-impact cardio movement targeting lower-body explosive power and stamina.',
        steps: [
          'Stand tall with feet hip-width apart.',
          'Run in place, driving your knees up to hip height.',
          'Pump your arms in coordination with your legs.',
          'Stay on the balls of your feet and maintain a fast pace.'
        ],
        benefits: [
          'Improves running mechanics and calf elasticity.',
          'Very high calorie expenditure.',
          'Strengthens hip flexors and calves.'
        ],
        mistakes: [
          'Leaning backward (keep a slight forward lean).',
          'Not raising knees high enough.'
        ],
        safetyTips: [
          'Land softly to minimize joint load.',
          'Substitute with marching in place if knees are sensitive.'
        ],
        duration: 40,
        sets: 3,
        reps: 60,
        animationPath: 'assets/gifs/6c1a4598-1177-11ee-9e88-bf9e8c56d70c.gif', // Fallback
      ),
      Exercise(
        id: 'full_inchworm',
        name: 'Standard Inchworm',
        bodyPart: 'Full Body',
        difficulty: 'Beginner',
        description: 'A full-body stretching and strengthening move that builds stability.',
        steps: [
          'Stand tall, then bend at your hips to touch the floor in front of you.',
          'Walk your hands forward, keeping legs straight, until you are in a high plank.',
          'Hold the plank for 1 second.',
          'Walk your feet forward with straight legs until they reach your hands, then stand up.'
        ],
        benefits: [
          'Stretches the hamstrings and calves.',
          'Strengthens core and shoulders.',
          'Excellent dynamic warm-up.'
        ],
        mistakes: [
          'Letting the hips droop down below the spine in plank.',
          'Bending knees too early.'
        ],
        safetyTips: [
          'Perform slowly and feel the stretch along your back leg chain.',
          'Do not lock elbows.'
        ],
        duration: 45,
        sets: 3,
        reps: 8,
        animationPath: 'assets/gifs/6c1a4598-1177-11ee-9e88-bf9e8c56d70c.gif', // Fallback
      ),

      // ==========================================
      // RECOVERY & STRETCHING (11 Exercises to reach 54)
      // ==========================================
      Exercise(
        id: 'rec_child_pose',
        name: "Child's Pose",
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'A restful yoga stretch that relaxes the lower back, hips, and shoulders.',
        steps: [
          'Kneel on the floor, touch your big toes together, and sit on your heels.',
          'Separate your knees about hip-width apart.',
          'Exhale and lay your torso down between your thighs.',
          'Extend your arms forward, palms down, and rest your forehead on the floor.'
        ],
        benefits: [
          'Stretches the back, hips, and thighs.',
          'Calms the central nervous system.',
          'Relieves physical fatigue.'
        ],
        mistakes: [
          'Lifting the glutes off the heels.',
          'Tensing the shoulders (let them relax down).'
        ],
        safetyTips: [
          'Place a pillow under your hips or knees if you feel discomfort.',
          'Breathe deeply into your lower back.'
        ],
        duration: 60,
        sets: 1,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_cat_cow',
        name: 'Cat-Cow Flow',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'Mobilizes the spine through flexion and extension.',
        steps: [
          'Start on your hands and knees in a tabletop position.',
          'Inhale, arch your back, drop your belly, and look up towards the ceiling (Cow).',
          'Exhale, round your spine toward the ceiling, tuck your chin, and pull your tailbone in (Cat).',
          'Flow smoothly between these two poses.'
        ],
        benefits: [
          'Increases spinal flexibility and lubrication.',
          'Relieves tension in the neck and lower back.',
          'Coordinates movement with breath.'
        ],
        mistakes: [
          'Forcing the neck back too far in Cow.',
          'Moving too quickly without breathing.'
        ],
        safetyTips: [
          'Perform gently; do not force end ranges if stiff.',
          'Keep your shoulders away from ears.'
        ],
        duration: 45,
        sets: 2,
        reps: 10,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_hamstring',
        name: 'Seated Hamstring Stretch',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'A static stretch to lengthen tight hamstrings and relieve lower back pressure.',
        steps: [
          'Sit on the floor with both legs extended straight in front of you.',
          'Keep your spine tall and flex your toes toward your face.',
          'Hinge forward from the hips and reach your hands toward your feet.',
          'Hold the stretch when you feel tension, keeping your back flat.'
        ],
        benefits: [
          'Lengthens hamstrings.',
          'Reduces lower back tightness.',
          'Improves seated posture.'
        ],
        mistakes: [
          'Rounding the upper spine to force hands forward.',
          'Locking knees painfully.'
        ],
        safetyTips: [
          'Bend knees slightly if hamstrings are very tight.',
          'Do not bounce; hold statically.'
        ],
        duration: 40,
        sets: 2,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_quad',
        name: 'Standing Quad Stretch',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'Stretches the front of the thigh (quadriceps) and hip flexors.',
        steps: [
          'Stand tall and hold a wall or chair for balance.',
          'Bend your right knee and bring your heel toward your glutes.',
          'Grasp your ankle with your right hand.',
          'Gently pull your heel closer, keeping your knees together and posture straight.'
        ],
        benefits: [
          'Relieves tightness in the quadriceps.',
          'Stretches the hip flexors.',
          'Improves standing balance.'
        ],
        mistakes: [
          'Letting the stretched knee flare outward.',
          'Arching the lower back.'
        ],
        safetyTips: [
          'Squeeze your glutes of the stretched leg to deepen the quad stretch.',
          'Do not pull with excessive force.'
        ],
        duration: 30,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_shoulder_roll',
        name: 'Shoulder Rolls',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'A simple recovery movement to release shoulder tension and improve posture.',
        steps: [
          'Stand or sit comfortably with arms relaxed by your sides.',
          'Inhale and shrug your shoulders up towards your ears.',
          'Roll your shoulders backward and down in a circular motion.',
          'Complete circle, then repeat. Reverse direction halfway.'
        ],
        benefits: [
          'Releases upper trap and neck stiffness.',
          'Improves upper chest opening.',
          'Increases shoulder blade blood flow.'
        ],
        mistakes: [
          'Moving too fast.',
          'Tensing the jaw.'
        ],
        safetyTips: [
          'Keep neck still during rolls.',
          'Perform in a smooth, circular track.'
        ],
        duration: 30,
        sets: 2,
        reps: 20,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_hip_flexor',
        name: 'Kneeling Hip Flexor Stretch',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'Opens up tight hip flexors (psoas) from sitting.',
        steps: [
          'Kneel on your right knee, left foot flat in front, forming 90-degree angles.',
          'Keep your torso upright and tuck your pelvis forward.',
          'Lean forward slightly until you feel a stretch in the front of your right hip.',
          'Hold, then switch sides.'
        ],
        benefits: [
          'Counters sitting posture tightness.',
          'Eases lower back discomfort.',
          'Improves hip extension mobility.'
        ],
        mistakes: [
          'Arching the lower back instead of tucking the pelvis.',
          'Leaning too far forward, hyperextending.'
        ],
        safetyTips: [
          'Place a cushion under the back knee for comfort.',
          'Keep chest vertical.'
        ],
        duration: 40,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_cobra_stretch_static',
        name: 'Static Cobra Stretch',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'A static hold to stretch the abdominal wall and chest.',
        steps: [
          'Lie face down, palms on floor near shoulders.',
          'Press your hands to lift your upper body, keeping your hips on the floor.',
          'Look forward and hold, breathing deeply.',
          'Keep your shoulders down, away from your ears.'
        ],
        benefits: [
          'Stretches abdominal wall muscles.',
          'Improves spinal extension.',
          'Opens chest area.'
        ],
        mistakes: [
          'Shrugging shoulders.',
          'Lifting hips completely off floor.'
        ],
        safetyTips: [
          'If lower back feels pinched, rest on forearms (Sphinx pose) instead of hands.'
        ],
        duration: 30,
        sets: 2,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif',
      ),
      Exercise(
        id: 'rec_puppy_dog',
        name: 'Puppy Dog Pose',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'Stretches the upper back, shoulders, and latissimus dorsi.',
        steps: [
          'Start on all fours.',
          'Walk your hands forward, keeping your hips stacked directly over your knees.',
          'Lower your chest towards the floor, resting your forehead or chin down.',
          'Reach your arms forward, feeling the pull in your armpits and back.'
        ],
        benefits: [
          'Deep shoulder stretch.',
          'Opens up the thoracic spine.',
          'Relieves stress.'
        ],
        mistakes: [
          'Letting hips slide forward past knees.',
          'Holding breath.'
        ],
        safetyTips: [
          'Place forehead on a block or towel if it does not reach the ground.'
        ],
        duration: 45,
        sets: 2,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_butterfly',
        name: 'Butterfly Stretch',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'Opens up the inner thighs, groin, and hips.',
        steps: [
          'Sit tall on the floor, bend your knees, and press the soles of your feet together.',
          'Hold your feet or ankles.',
          'Keep your back straight, hinge forward slightly, and gently press knees toward floor.'
        ],
        benefits: [
          'Excellent hip opener.',
          'Stretches inner thighs (adductors).',
          'Calms body.'
        ],
        mistakes: [
          'Rounding the back dramatically.',
          'Bouncing the knees rapidly (hold statically).'
        ],
        safetyTips: [
          'Sit on a folded blanket to make sitting upright easier.'
        ],
        duration: 40,
        sets: 2,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_thread_needle',
        name: 'Thread the Needle',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'A rotational stretch that opens the upper back and shoulders.',
        steps: [
          'Start on hands and knees.',
          'Slide your right arm under your left arm, palm facing up, lowering your right shoulder and cheek to floor.',
          'Look toward your right hand.',
          'Breathe deeply, then switch sides.'
        ],
        benefits: [
          'Improves thoracic rotation.',
          'Stretches the upper back and posterior shoulder.',
          'Very relaxing.'
        ],
        mistakes: [
          'Shifting hips out of alignment.',
          'Putting too much weight on the neck.'
        ],
        safetyTips: [
          'Support your head with a pillow if the floor is too far.'
        ],
        duration: 40,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'rec_torso_twist',
        name: 'Lying Spinal Twist',
        bodyPart: 'Recovery',
        difficulty: 'Beginner',
        description: 'Relieves tension in the lower back and outer hips.',
        steps: [
          'Lie on your back, hug your knees to your chest.',
          'Extend your arms out to the sides in a T shape.',
          'Lower both knees to the right side, keeping both shoulder blades flat on floor.',
          'Turn head to left, hold, then repeat on opposite side.'
        ],
        benefits: [
          'Stretches glutes and lower back.',
          'Improves lumbar rotation.',
          'Excellent closing stretch.'
        ],
        mistakes: [
          'Letting the shoulder blades lift off the floor.',
          'Forcing knees down with sharp force.'
        ],
        safetyTips: [
          'If knees do not touch the floor, place a pillow under them for support.'
        ],
        duration: 45,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),

      // ==========================================
      // YOGA (15 Exercises)
      // ==========================================
      Exercise(
        id: 'yoga_mountain_pose',
        name: 'Mountain Pose (Tadasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'The foundation of all standing yoga poses, improving posture and balance.',
        steps: [
          'Stand with feet together, big toes touching.',
          'Engage your thighs and lift your kneecaps.',
          'Draw your belly in and lift your chest.',
          'Let your arms hang by your sides, palms facing forward.',
          'Hold and breathe deeply.'
        ],
        benefits: [
          'Improves posture.',
          'Strengthens thighs, knees, and ankles.',
          'Firms abdomen and buttocks.'
        ],
        mistakes: [
          'Locking the knees.',
          'Shrugging the shoulders.'
        ],
        safetyTips: [
          'Keep weight distributed evenly across both feet.'
        ],
        duration: 30,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/mountain_pose.gif',
      ),
      Exercise(
        id: 'yoga_downward_dog',
        name: 'Downward-Facing Dog (Adho Mukha Svanasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'One of the most recognizable yoga poses, stretching the entire body.',
        steps: [
          'Start on your hands and knees.',
          'Lift your hips towards the ceiling, forming an inverted V-shape.',
          'Press your palms into the floor and stretch your heels toward the ground.',
          'Keep your head between your arms, looking toward your knees.'
        ],
        benefits: [
          'Calms the brain and helps relieve stress.',
          'Energizes the body.',
          'Stretches the shoulders, hamstrings, calves, and hands.'
        ],
        mistakes: [
          'Rounding the back.',
          'Putting too much weight on the wrists.'
        ],
        safetyTips: [
          'Bend your knees slightly if your hamstrings are tight.'
        ],
        duration: 45,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/downward_dog.gif',
      ),
      Exercise(
        id: 'yoga_warrior_1',
        name: 'Warrior I (Virabhadrasana I)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'A powerful standing pose that builds strength and focus.',
        steps: [
          'Step your right foot forward and bend the knee to 90 degrees.',
          'Turn your left foot out slightly and press it into the floor.',
          'Reach your arms overhead, palms facing each other.',
          'Lift your chest and look forward or slightly up.'
        ],
        benefits: [
          'Strengthens shoulders, arms, and back muscles.',
          'Stretches the chest, lungs, and shoulders.',
          'Strengthens and stretches the thighs, calves, and ankles.'
        ],
        mistakes: [
          'Letting the front knee collapse inward.',
          'Arching the lower back too much.'
        ],
        safetyTips: [
          'Ensure the front knee is directly above the ankle.'
        ],
        duration: 40,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/warrior_1.gif',
      ),
      Exercise(
        id: 'yoga_warrior_2',
        name: 'Warrior II (Virabhadrasana II)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'Improves stamina and concentration while stretching the hips.',
        steps: [
          'Step your feet wide apart.',
          'Turn your right foot out 90 degrees and your left foot in slightly.',
          'Bend your right knee over the right ankle.',
          'Extend your arms out to the sides at shoulder height.',
          'Look over your right hand.'
        ],
        benefits: [
          'Strengthens and stretches the legs and ankles.',
          'Stretches the groins, chest, and shoulders.',
          'Increases stamina.'
        ],
        mistakes: [
          'Leaning forward over the front leg.',
          'Letting the back arm drop.'
        ],
        safetyTips: [
          'Keep your torso centered over your hips.'
        ],
        duration: 40,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/warrior_2.gif',
      ),
      Exercise(
        id: 'yoga_triangle_pose',
        name: 'Triangle Pose (Trikonasana)',
        bodyPart: 'Yoga',
        difficulty: 'Intermediate',
        description: 'A foundational standing pose that stretches the sides of the body.',
        steps: [
          'Stand with feet wide apart.',
          'Turn right foot out and left foot in slightly.',
          'Reach right arm forward and then down toward the shin or floor.',
          'Reach left arm toward the ceiling.',
          'Look up at the left hand.'
        ],
        benefits: [
          'Stretches and strengthens the thighs, knees, and ankles.',
          'Stretches the hips, groins, hamstrings, and calves.',
          'Stimulates the abdominal organs.'
        ],
        mistakes: [
          'Locking the front knee.',
          'Collapsing the chest toward the floor.'
        ],
        safetyTips: [
          'Keep both sides of your torso long.'
        ],
        duration: 35,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/triangle_pose.gif',
      ),
      Exercise(
        id: 'yoga_tree_pose',
        name: 'Tree Pose (Vrksasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'Improves balance and focus while strengthening the legs.',
        steps: [
          'Stand tall in Mountain Pose.',
          'Shift weight to the left foot and place the right foot on the left inner thigh or calf (avoid the knee).',
          'Bring palms together in front of the chest or reach overhead.',
          'Find a focal point and breathe.'
        ],
        benefits: [
          'Strengthens thighs, calves, ankles, and spine.',
          'Stretches the groins and inner thighs, chest, and shoulders.',
          'Improves sense of balance.'
        ],
        mistakes: [
          'Placing the foot directly on the knee joint.',
          'Holding the breath.'
        ],
        safetyTips: [
          'Use a wall for balance if needed.'
        ],
        duration: 30,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/tree_pose.gif',
      ),
      Exercise(
        id: 'yoga_plank_pose',
        name: 'Plank Pose (Phalakasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'A core-strengthening pose often used in Sun Salutations.',
        steps: [
          'Start on hands and knees.',
          'Step your feet back and lift your knees off the floor.',
          'Keep your body in a straight line from head to heels.',
          'Press the floor away with your hands.'
        ],
        benefits: [
          'Strengthens the core, arms, and wrists.',
          'Tones the abdomen.',
          'Improves posture.'
        ],
        mistakes: [
          'Sagging the hips.',
          'Hiking the hips too high.'
        ],
        safetyTips: [
          'Keep your neck neutral, looking at the floor.'
        ],
        duration: 45,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/plank.gif',
      ),
      Exercise(
        id: 'yoga_cobra_pose',
        name: 'Cobra Pose (Bhujangasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'A gentle backbend that opens the chest.',
        steps: [
          'Lie face down on the floor.',
          'Place hands under your shoulders.',
          'Lift your chest off the floor by straightening your arms slightly.',
          'Keep your elbows close to your body.'
        ],
        benefits: [
          'Strengthens the spine.',
          'Stretches chest and lungs, shoulders, and abdomen.',
          'Firms the buttocks.'
        ],
        mistakes: [
          'Over-extending the neck.',
          'Using too much arm strength instead of back strength.'
        ],
        safetyTips: [
          'Don\'t push yourself to a full extension if it feels uncomfortable.'
        ],
        duration: 30,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif',
      ),
      Exercise(
        id: 'yoga_bridge_pose',
        name: 'Bridge Pose (Setu Bandha Sarvangasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'Stretches the chest, neck, and spine.',
        steps: [
          'Lie on your back with knees bent and feet flat on the floor.',
          'Lift your hips toward the ceiling.',
          'Interlace your hands under your back and press your arms into the floor.',
          'Keep your thighs and feet parallel.'
        ],
        benefits: [
          'Stretches the chest, neck, and spine.',
          'Calms the brain and helps alleviate stress.',
          'Improves digestion.'
        ],
        mistakes: [
          'Letting the knees splay out.',
          'Turning the head while in the pose.'
        ],
        safetyTips: [
          'Keep the back of your neck long on the floor.'
        ],
        duration: 40,
        sets: 2,
        reps: 1,
        animationPath: 'assets/gifs/glute_bridge.gif',
      ),
      Exercise(
        id: 'yoga_child_pose',
        name: "Child's Pose (Balasana)",
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'A resting pose that gently stretches the hips and back.',
        steps: [
          'Kneel on the floor and sit on your heels.',
          'Fold forward and rest your forehead on the floor.',
          'Extend your arms forward or rest them alongside your body.',
          'Breathe deeply.'
        ],
        benefits: [
          'Gently stretches the hips, thighs, and ankles.',
          'Calms the brain and helps relieve stress and fatigue.',
          'Relieves back and neck pain.'
        ],
        mistakes: [
          'Holding tension in the shoulders.',
          'Struggling to reach the floor (use a prop).'
        ],
        safetyTips: [
          'If you have knee issues, place a blanket between your calves and thighs.'
        ],
        duration: 60,
        sets: 1,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'yoga_cat_cow',
        name: 'Cat-Cow Pose (Marjaryasana-Bitilasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'A gentle flow between two poses to warm up the spine.',
        steps: [
          'Start on hands and knees.',
          'Inhale, arch your back, and look up (Cow).',
          'Exhale, round your spine, and tuck your chin (Cat).',
          'Repeat with your breath.'
        ],
        benefits: [
          'Stretches the back torso and neck.',
          'Provides a gentle massage to the spine and abdominal organs.',
          'Coordinates movement with breath.'
        ],
        mistakes: [
          'Moving too fast.',
          'Holding the breath.'
        ],
        safetyTips: [
          'Move within a comfortable range of motion.'
        ],
        duration: 45,
        sets: 2,
        reps: 10,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'yoga_pigeon_pose',
        name: 'Half Pigeon Pose (Ardha Kapotasana)',
        bodyPart: 'Yoga',
        difficulty: 'Intermediate',
        description: 'A deep hip opener that stretches the glutes and hip flexors.',
        steps: [
          'From Downward Dog, bring your right knee forward toward your right wrist.',
          'Lay your right shin on the floor.',
          'Extend your left leg straight back.',
          'Fold forward over your front leg if comfortable.'
        ],
        benefits: [
          'Deeply stretches the hip flexors and glutes.',
          'Relieves tension in the lower back.',
          'Improves hip mobility.'
        ],
        mistakes: [
          'Collapsing onto one side of the hip.',
          'Pushing through knee pain.'
        ],
        safetyTips: [
          'Flex your front foot to protect the knee.'
        ],
        duration: 50,
        sets: 2,
        reps: 2,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'yoga_corpse_pose',
        name: 'Corpse Pose (Savasana)',
        bodyPart: 'Yoga',
        difficulty: 'Beginner',
        description: 'The final relaxation pose in most yoga sessions.',
        steps: [
          'Lie flat on your back.',
          'Let your arms and legs fall open naturally.',
          'Close your eyes and focus on your breath.',
          'Release all tension in the body.'
        ],
        benefits: [
          'Calms the brain and helps relieve stress.',
          'Relaxes the body.',
          'Reduces blood pressure.'
        ],
        mistakes: [
          'Falling asleep.',
          'Letting the mind wander excessively.'
        ],
        safetyTips: [
          'Keep the body warm during this pose.'
        ],
        duration: 120,
        sets: 1,
        reps: 1,
        animationPath: 'assets/gifs/cobra.gif', // Fallback
      ),
      Exercise(
        id: 'yoga_plow_pose',
        name: 'Plow Pose (Halasana)',
        bodyPart: 'Yoga',
        difficulty: 'Advanced',
        description: 'An inversion that stretches the back and calms the nervous system.',
        steps: [
          'Lie on your back.',
          'Lift your legs and hips over your head until your toes touch the floor behind you.',
          'Support your lower back with your hands or interlace them on the floor.',
          'Breathe deeply.'
        ],
        benefits: [
          'Stretches the shoulders and spine.',
          'Calms the brain.',
          'Stimulates abdominal organs and the thyroid gland.'
        ],
        mistakes: [
          'Turning the head while in the pose.',
          'Forcing the feet to the floor.'
        ],
        safetyTips: [
          'Do not perform if you have neck or shoulder injuries.'
        ],
        duration: 30,
        sets: 1,
        reps: 1,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
      Exercise(
        id: 'yoga_boat_pose',
        name: 'Boat Pose (Navasana)',
        bodyPart: 'Yoga',
        difficulty: 'Intermediate',
        description: 'A balancing pose that strengthens the core.',
        steps: [
          'Sit on the floor with knees bent.',
          'Lift your feet off the floor and balance on your sit bones.',
          'Extend your arms forward parallel to the floor.',
          'Straighten your legs if possible to form a V-shape.'
        ],
        benefits: [
          'Strengthens the abdomen, hip flexors, and spine.',
          'Stimulates the kidneys, thyroid and prostate glands, and intestines.',
          'Improves balance.'
        ],
        mistakes: [
          'Rounding the back.',
          'Holding the breath.'
        ],
        safetyTips: [
          'Keep your chest lifted and spine long.'
        ],
        duration: 30,
        sets: 3,
        reps: 1,
        animationPath: 'assets/gifs/glute_bridge.gif', // Fallback
      ),
    ];
  }
}
