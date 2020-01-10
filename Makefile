default:
	processing-java --sketch=ccc_robot_movement --run
	ffmpeg -r 60 -i %d.png movie.mp4

