default:
	processing-java --sketch=ccc_robot_movement --run
	ffmpeg -r 60 -i ccc_robot_movement/%d.png movie.mp4 -y

