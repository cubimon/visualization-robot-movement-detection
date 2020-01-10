
enum Action {
  NONE,
  WALKING,
  DETECTING,
}

enum RobotState {
  DETECTING,
  ROTATE_TO_STREET,
  WALKING,
  ROTATE_TO_SHELF,
}

int r2d2_body_size = 80;
void r2d2() {
  pushMatrix();
  pushStyle();

  //stroke(1);
  noStroke();
  int body_size = r2d2_body_size;
  int eye_size_max = 87;
  int eye_size_min = 65;
  int eye_angle = 27;
  int arm_width = 20 / 2;
  int arm_length = 35;
  int outer_arm_line = (int) (arm_width*0.75);
  int eye_size_x = 12;
  int eye_size_y = 6;
  color blue = #254a86;
  color gray = #dbdbdb;
  color lightdarkgray = #a0a0a0;
  color darkgray = #909090;
  fill(gray);
  circle(0, 0, 80);
  fill(255);
  rect(40, -arm_length / 2, arm_width, arm_length);
  rect(-50, -arm_length / 2, arm_width, arm_length);
  stroke(0);
  line(40+outer_arm_line, -arm_length / 2, 40+outer_arm_line, arm_length / 2);
  line(-40-outer_arm_line, -arm_length / 2, -40-outer_arm_line, arm_length / 2);
  noStroke();
  // right eye
  pushStyle();
  pushMatrix();
  fill(blue);
  rotate(radians(-90+10));
  arc(0, 0, eye_size_max, eye_size_max, 
    radians(-eye_angle/2), radians(eye_angle/2));
  fill(gray);
  arc(0, 0, eye_size_min, eye_size_min, 
    radians(-eye_angle/2-1), radians(eye_angle/2+1));
  fill(0);
  ellipse((eye_size_max + eye_size_min)/4+1, 0, eye_size_y, eye_size_x);
  popStyle();
  popMatrix();
  // first inner
  int gap_size = 2;
  int inner_size = (int) (body_size * 0.65);
  noStroke();
  fill(blue);
  circle(0, 0, inner_size);
  pushMatrix();
  fill(gray);
  for (int i = 0; i < 6; i++) {
    rect(-gap_size/2, 0, gap_size, inner_size/2);
    rotate(radians(60));
  }
  popMatrix();
  // more inner
  fill(gray);
  inner_size = (int) (inner_size * 0.35);
  circle(0, 0, inner_size);
  fill(blue);
  inner_size = (int) (inner_size * 0.8);
  circle(0, 0, inner_size);
  fill(darkgray);
  inner_size = (int) (inner_size * 0.5);
  circle(0, 0, inner_size);
  fill(blue);
  inner_size = (int) (inner_size * 0.5);
  circle(0, 0, inner_size);
  // left eye
  pushMatrix();
  rotate(radians(-90-25));
  fill(lightdarkgray);
  int inner_left_eye_width = 15;
  int outer_left_eye_width = 9;
  quad(eye_size_min/2, -inner_left_eye_width/2, 
    eye_size_max/2, -outer_left_eye_width/2, 
    eye_size_max/2, outer_left_eye_width/2, 
    eye_size_min/2, inner_left_eye_width/2);
  popMatrix();
  // left back antenna
  fill(lightdarkgray);
  int antenna_radius = 10;
  circle(-10, 15, antenna_radius);

  popMatrix();
  popStyle();
}

int crate_width = 40;
void crate() {
  color darkdarkblue = #09083d;
  color darkblue = #3534c1;
  color blue = #5857d9;
  color lightblue = #6c6bf1;
  //int crate_width = 40;
  int crate_height = 60;
  int crate_radius = 0;
  int crate_border = 5;
  int opening_height = (int) (crate_height * 0.17);
  // border border
  stroke(0);
  //stroke(255);
  strokeWeight(1);
  rect(-crate_width/2-crate_border/2-0.5, -crate_height/2-crate_border/2-0.5, crate_width+crate_border+0.5, crate_height+crate_border,
    crate_radius, crate_radius, crate_radius, crate_radius);
  // main chest rect with border
  pushMatrix();
  pushStyle();
  fill(blue);
  stroke(darkblue);
  strokeWeight(crate_border);
  rect(-crate_width/2, -crate_height/2, crate_width, crate_height, 
    crate_radius, crate_radius, crate_radius, crate_radius);
  // opening
  noStroke();
  fill(lightblue);
  rect(-crate_width/2+crate_border/2+1, crate_height/2-opening_height, crate_width-crate_border, opening_height+1+crate_border/2);
  // border border small pieces
  stroke(darkdarkblue);
  strokeWeight(2);
  strokeCap(SQUARE);
  // lower two
  float factor = 0.7f;
  line(crate_width/2-crate_border/2, crate_height*factor-crate_height/2, 
    crate_width/2+crate_border/2+1, crate_height*factor-crate_height/2);
  line(-crate_width/2-crate_border/2-1, crate_height*factor-crate_height/2, 
    -crate_width/2+crate_border/2, crate_height*factor-crate_height/2);
  // upper two
  factor = 0.3f;
  line(crate_width/2-crate_border/2, crate_height*factor-crate_height/2, 
    crate_width/2+crate_border/2+1, crate_height*factor-crate_height/2);
  line(-crate_width/2-crate_border/2-1, crate_height*factor-crate_height/2, 
    -crate_width/2+crate_border/2, crate_height*factor-crate_height/2);
  // back
  line(0, -crate_height/2+crate_border/2, 
    0, -crate_height/2-crate_border/2-1);
  popMatrix();
  popStyle();
}

int shelf_crate_distance = 70; // distance between two crates of a shelf (horizontally)
int shelf_distance = 500; // distance between two shelfs (horizontally)
int shelf_crate_count = 3; // number of crates per shelf
void shelf() {
  pushMatrix();
  pushStyle();
  noStroke();
  int crate_count = shelf_crate_count;
  int tube_width = 6;
  int shelf_depth = 90;
  int conjunction_width = 8;
  int conjunction_length = 15;
  float conjunction_offset = (conjunction_width - tube_width) / 2;
  color tube_color = #9b9b9b;
  color tube_color_light = #b0b0b0;
  color conjunction_color = #000000;
  fill(tube_color);
  int tube_offset_x = shelf_crate_distance/2+tube_width/2;
  int tube_offset_y = shelf_depth/2-tube_width/2;
  for (int i = 0; i < crate_count; i++) {
    pushMatrix();
    pushStyle();
    translate(shelf_crate_distance*i, 0);
    crate();
    popMatrix();
    popStyle();
    rect(-tube_offset_x+shelf_crate_distance*i, tube_offset_y, tube_width, -shelf_depth);
  }
  // right tube
  rect(-tube_offset_x+shelf_crate_distance*crate_count, tube_offset_y, tube_width, -shelf_depth);
  // back tube
  rect(-tube_offset_x, tube_offset_y-shelf_depth, shelf_crate_distance*crate_count, tube_width);
  // front tube
  fill(tube_color_light);
  rect(-tube_offset_x, tube_offset_y, shelf_crate_distance*crate_count+tube_width, tube_width);

  // conjunction front
  fill(conjunction_color);
  // bottom left conjunction
  // to right
  rect(-tube_offset_x, tube_offset_y-conjunction_offset, conjunction_length, conjunction_width);
  // to top
  rect(-tube_offset_x-conjunction_offset, tube_offset_y+tube_width, conjunction_width, -conjunction_length);
  for (int i = 1; i < crate_count; i++) {
    pushMatrix();
    translate(shelf_crate_distance*i, 0);
    // to right
    rect(-tube_offset_x, tube_offset_y-conjunction_offset, conjunction_length, conjunction_width);
    // to left
    rect(-tube_offset_x+tube_width, tube_offset_y-conjunction_offset, -conjunction_length, conjunction_width);
    // to top
    rect(-tube_offset_x-conjunction_offset, tube_offset_y+tube_width, conjunction_width, -conjunction_length);
    popMatrix();
  }
  // bottom right conjunction
  // to left
  rect(-tube_offset_x+shelf_crate_distance*crate_count+tube_width, tube_offset_y-conjunction_offset, -conjunction_length, conjunction_width);
  // to top
  rect(-tube_offset_x+shelf_crate_distance*crate_count-conjunction_offset, tube_offset_y+tube_width, conjunction_width, -conjunction_length);

  // conjunction back
  // top left conjunction
  // to right
  rect(-tube_offset_x, tube_offset_y-conjunction_offset-shelf_depth, conjunction_length, conjunction_width);
  // to bottom
  rect(-tube_offset_x-conjunction_offset, tube_offset_y-shelf_depth, conjunction_width, conjunction_length);
  for (int i = 1; i < crate_count; i++) {
    pushMatrix();
    translate(shelf_crate_distance*i, 0);
    // to right
    rect(-tube_offset_x, tube_offset_y-shelf_depth-conjunction_offset, conjunction_length, conjunction_width);
    // to left
    rect(-tube_offset_x+tube_width, tube_offset_y-shelf_depth-conjunction_offset, -conjunction_length, conjunction_width);
    // to bottom
    rect(-tube_offset_x-conjunction_offset, tube_offset_y-shelf_depth, conjunction_width, conjunction_length);
    popMatrix();
  }
  // top right conjunction
  // to left
  rect(-tube_offset_x+shelf_crate_distance*crate_count+tube_width, tube_offset_y-shelf_depth-conjunction_offset, -conjunction_length, conjunction_width);
  // to bottom
  rect(-tube_offset_x+shelf_crate_distance*crate_count-conjunction_offset, tube_offset_y-shelf_depth, conjunction_width, conjunction_length);

  popMatrix();
  popStyle();
}

void detection_laser(int progress_frame_count) {
  pushMatrix();
  pushStyle();
  int angle_range = 40;
  float rpm = 3.0;
  float time_progress = (progress_frame_count * frameDuration) / 1000.0; // in seconds
  int current_angle = ceil(angle_range/2*sin(time_progress*rpm*PI)); // deg
  color laser_color = #ff0000;
  int laser_length = 150;
  int laser_width = 2;
  stroke(laser_color);
  strokeWeight(laser_width);
  rotate(radians(current_angle));
  line(0, 0, 0, laser_length);
  popStyle();
  popMatrix();
}

void screw() {
  pushMatrix();
  pushStyle();
  color lightlightgray = #c0c0c0;
  color lightgray = #a0a0a0;
  color gray = #909090;
  color lightdarkgray = #707070;
  color darkgray = #505050;
  int head_width = 20;
  int head_length = 5;
  int thread_inner_size = 4;
  int thread_outer_size = 6;
  int thread_length = 30;
  float thread_single_size = 1;
  float thread_single_offset = 1.5;
  int tip_length = 0;
  // head
  noStroke();
  fill(lightlightgray);
  rect(-head_width/2, 0, head_width, head_length);
  fill(gray);
  float first_factor = 0.2;
  float second_factor = 0.8;
  rect(-head_width/2+head_width*first_factor, 0, 
    head_width*(second_factor-first_factor), head_length);
  stroke(darkgray);
  line(-head_width/2+head_width*first_factor, 0,
    -head_width/2+head_width*first_factor, head_length);
  line(-head_width/2+head_width*second_factor, 0,
      -head_width/2+head_width*second_factor, head_length);
  // thread
  noStroke();
  fill(lightgray);
  rect(-thread_inner_size/2, head_length, thread_inner_size, thread_length);
  stroke(lightdarkgray);
  int y = head_length+2;
  while (y + thread_single_size*2+thread_single_offset < head_length+thread_length) {
    line(-thread_outer_size/2, y, thread_outer_size/2, y+thread_single_size);
    y+=thread_single_size*2+thread_single_offset;
  }
  // tip
  noStroke();
  triangle((int)(-thread_inner_size/2), head_length+thread_length,
    (int)(thread_inner_size/2), head_length+thread_length,
    0, head_length+thread_length+tip_length);
  popMatrix();
  popStyle();
}

void nut(color bgcolor) {
  pushMatrix();
  pushStyle();
  noStroke();
  color gray = #909090;
  color lightgray = #c0c0c0;
  color lightlightgray = #e0e0e0;
  int nut_outer_diameter = 40;
  int nut_thread_diameter = 24;
  int nut_inner_diameter = 20;
  // outer sextant
  noStroke();
  fill(lightlightgray);
  int hex_half_width = (int) (floor(tan(radians(30))*nut_outer_diameter/2));
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    rotate(radians(i*60));
    rect(-hex_half_width, nut_outer_diameter/2,
      hex_half_width*2, -(nut_outer_diameter-nut_inner_diameter)/2);
    popMatrix();
  }
  // circle
  fill(lightgray);
  circle(0, 0, nut_outer_diameter);
  // thread circle
  fill(gray);
  circle(0, 0, nut_thread_diameter);
  // clear
  fill(bgcolor);
  circle(0, 0, nut_inner_diameter);
  popMatrix();
  popStyle();
}

void history(ArrayList<Action> history, int historySizeMax) {
  pushMatrix();
  pushStyle();
  noStroke();
  int statPos = (int) (height*0.78);
  int statWidth = (int) (width * 0.8);
  int statHeight = (int) (height * 0.05);
  color walkingColor = #ff5b00;
  color detectingColor = #21a0ff;
  color defaultTextColor = 255;
  int labelSize = (int) (statHeight*0.9);
  int startX = (width-statWidth)/2;
  if (history.isEmpty()) {
    return;
  }
  // bar
  for (int i = 0; i < history.size(); i++) {
    Action action = history.get(i);
    if (action == Action.WALKING) {
      fill(walkingColor);
    } else if (action == Action.DETECTING) {
      fill(detectingColor);
    }
    float offset = (float) i/historySizeMax*statWidth;
    float singleWidth = ceil(1.0f/historySizeMax*statWidth);
    rect(floor(startX+offset), statPos,
      singleWidth, statHeight);
  }
  // bar scale (label in bar)
  stroke(defaultTextColor);
  fill(defaultTextColor);
  int barDuration = 0;
  int barSec = -1;
  // expectedFrameRate = number of frames in one second
  // expectedFrameRate * width per frame = width of one second
  float secWidth = (float) expectedFrameRate/historySizeMax*statWidth;
  for (int i = history.size()-1; i>= 0; i--) {
    int reverseIndex = history.size()-1-i;
    if (reverseIndex * frameDuration - barDuration > 1000) {
      float offset = (float) i/historySizeMax*statWidth;
      line(startX+offset, statPos, startX+offset, statPos+statHeight);
      String label = String.valueOf(barSec) + "s";
      float labelWidth = textWidth(label);
      text(label, startX+offset+(secWidth-labelWidth)/2, statPos+statHeight-(statHeight-textAscent())+1);
      barDuration += 1000;
      barSec--;
    }
  }
  // label
  int labelYPos = statPos+statHeight-statHeight-10;
  fill(defaultTextColor);
  textSize(labelSize);
  String label = "8 seconds history";
  float label_width = textWidth(label);
  text(label, ceil(startX+(statWidth-label_width)/2), labelYPos);
  // past
  text("past", startX, labelYPos);
  // now
  text("now", startX+statWidth-textWidth("now"), labelYPos);
  popMatrix();
  popStyle();
}

void totalStatistics() {
  pushStyle();
  int statPos = (int) (height*0.9);
  int statWidth = (int) (width * 0.8);
  int statHeight = (int) (height * 0.05);
  color walkingColor = #ff5b00;
  color detectingColor = #21a0ff;
  color defaultTextColor = 255;
  float percentWalking = (float) walkingFrameCount / totalFrameCount;
  float percentDetecting = (float) detectingFrameCount / totalFrameCount;
  int walkingWidth = (int) ceil(statWidth * percentWalking);
  int detectingWidth = (int) (statWidth * percentDetecting);
  int labelSize = (int) (statHeight*0.9);
  float paddingFactor = 0.03;
  int startX = (width-statWidth)/2;
  noStroke();
  // half bar
  fill(walkingColor);
  rect(startX, statPos, walkingWidth, statHeight);
  // label in bar
  textSize(labelSize);
  fill(defaultTextColor);
  int percentWalkingDisplay = ceil(percentWalking*100);
  String percentWalkingString = String.valueOf(percentWalkingDisplay) + "%";
  if (walkingWidth > statWidth*paddingFactor+textWidth(percentWalkingString)) {
    text(percentWalkingString, startX+statWidth*paddingFactor, statPos+statHeight-(statHeight-textAscent())+1);
  }
  // half bar
  fill(detectingColor);
  rect(startX+walkingWidth, statPos, detectingWidth, statHeight);
  // label in bar
  textSize(labelSize);
  fill(defaultTextColor);
  int percentDetectingDisplay = floor(percentDetecting*100);
  String percentDetectingString = String.valueOf(percentDetectingDisplay) + "%";
  if (detectingWidth > statWidth*paddingFactor+textWidth(percentDetectingString)) {
    text(percentDetectingString,
      startX+statWidth-statWidth*paddingFactor-textWidth(percentDetectingString),
      statPos+statHeight-(statHeight-textAscent())+1);
  }
  // label for both bars
  int labelYPos = statPos-10;
  float label_width = textWidth("total move/detection ratio");
  float xOffset = startX+(statWidth-label_width)/2;
  text("total ", xOffset, labelYPos);
  xOffset += textWidth("total ");
  fill(walkingColor);
  text("move", xOffset, labelYPos);
  xOffset += textWidth("move");
  fill(defaultTextColor);
  text("/", xOffset, labelYPos);
  xOffset += textWidth("/");
  fill(detectingColor);
  text("detection", xOffset, labelYPos);
  xOffset += textWidth("detection");
  fill(defaultTextColor);
  text(" ratio", xOffset, labelYPos);
  popStyle();
}

int walkingFrameCount = 0;
int detectingFrameCount = 0;
int totalFrameCount = 0;
ArrayList<Action> recentHistory = new ArrayList<Action>();
color backgroundColor = 100;
int expectedFrameRate = 60;
float frameDuration = 1000 / expectedFrameRate;
RobotState robotState = RobotState.DETECTING;
int robotStateStartFrameCount = 0; // time in frame count when we went into robotState
int nextCratePosition = 0; // position of next crate
float robotPosition = 0;
float robotRotation = 0;
float robotVelocity = 100; // pixel/sec
float robotAngularVelocity = 180; // degree/sec
int robotNextShelfGoal = 1; // next shelf to move to (0-shelf_crate_count)
float robotStartPosition = 0;
final int shelfCount = 3;
int[] shelfPositions = new int[shelfCount];

void setup() {
  size(800, 500);
  background(backgroundColor);
  for (int i = 0; i < 3; i++) {
    shelfPositions[i] = (i-1)*shelf_distance;
  }
}

void draw() {
  clear();
  background(backgroundColor);
  // determine current action
  Action currentAction = Action.WALKING;
  if (robotState != RobotState.DETECTING) {
    currentAction = Action.WALKING;
  } else {
    currentAction = Action.DETECTING;
  }
  // append action to history
  recentHistory.add(currentAction);
  float historySizeSec = 8.4;
  int historySizeMax = (int) (historySizeSec*expectedFrameRate);
  // 30fps
  if (recentHistory.size() > historySizeMax) {
    recentHistory.remove(0);
  }
  // total history stats
  switch(currentAction) {
    case WALKING:
      walkingFrameCount++;
      break;
    case DETECTING:
      detectingFrameCount++;
      break;
    default:
      assert(false);
  }
  totalFrameCount++;
  assert(walkingFrameCount + detectingFrameCount == totalFrameCount);
  // process current state
  switch(robotState) {
    case DETECTING:
      final int detectionTime = 2000; // milliseconds
      if ((frameCount - robotStateStartFrameCount) * frameDuration > detectionTime) {
        robotState = RobotState.ROTATE_TO_STREET;
        robotStateStartFrameCount = frameCount;
        println("rotating to street");
      }
      break;
    case ROTATE_TO_STREET:
      robotRotation = (frameCount - robotStateStartFrameCount) * frameDuration / 1000.0 * robotAngularVelocity;
      if (robotRotation > 90) {
        robotRotation = 90;
        robotState = RobotState.WALKING;
        robotStateStartFrameCount = frameCount;
        println("walking");
        robotStartPosition = robotPosition;
      }
      break;
    case WALKING:
      int target_distance = 0;
      if (robotNextShelfGoal == 0) {
        // move to next shelf
        target_distance = shelf_distance-(shelf_crate_count-1)*shelf_crate_distance;
      } else {
        // move to next crate of current shelf
        target_distance = shelf_crate_distance;
      }
      robotPosition = robotStartPosition + robotVelocity * (frameCount - robotStateStartFrameCount) * frameDuration / 1000.0;
      if (robotPosition > robotStartPosition + target_distance) {
        robotPosition = robotStartPosition + target_distance;
        robotNextShelfGoal = (robotNextShelfGoal + 1) % shelf_crate_count;
        if (robotNextShelfGoal == 0) {
          // we move to next shelf now, so we move all shelfs one further
          for (int i = 0; i < shelfCount; i++) {
            shelfPositions[i] += shelf_distance;
          }
        }
        robotState = RobotState.ROTATE_TO_SHELF;
        robotStateStartFrameCount = frameCount;
        println("rotating to shelf");
      }
      break;
    case ROTATE_TO_SHELF:
      robotRotation = 90.0 - (frameCount - robotStateStartFrameCount) * frameDuration / 1000.0 * robotAngularVelocity;
      if (robotRotation < 0) {
        robotRotation = 0;
        robotState = RobotState.DETECTING;
        robotStateStartFrameCount = frameCount;
        println("detecting");
      }
      break;
  }
  
  // render
  pushMatrix();
  translate(width/2, height/2);
  scale(1.6);
  translate(-robotPosition, 0);
  
  // shelf
  pushMatrix();
  translate(0, -r2d2_body_size*1.3);
  for (int shelfPosition : shelfPositions) {
    pushMatrix();
    translate(shelfPosition, 0);
    shelf();
    popMatrix();
  }
  popMatrix();

  // r2d2
  pushMatrix();
  translate(robotPosition, 0);
  rotate(radians(robotRotation));
  if (robotState == RobotState.DETECTING) {
    pushMatrix();
    rotate(-PI);
    detection_laser(frameCount - robotStateStartFrameCount);
    popMatrix();
  }
  r2d2();
  popMatrix();

  popMatrix();
  // directly on screen/overlay
  totalStatistics();
  history(recentHistory, historySizeMax);
  
  saveFrame(String.format("%d.png", frameCount));
  final int recordTimeSec = 20;
  if (frameCount > recordTimeSec*expectedFrameRate) {
    exit();
  }
} 
