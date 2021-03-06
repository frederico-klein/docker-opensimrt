BRANCH=$(git branch --show-current )

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform        
	docker run --rm -it \
		-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
		--device=/dev/dri:/dev/dri \
		mysablehats/opensim-rt:$BRANCH
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
	docker run --rm -it \
		-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
		--device=/dev/dri:/dev/dri \
		mysablehats/opensim-rt:$BRANCH
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
	docker run --rm -it \
		-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
		--device=/dev/dri:/dev/dri \
		mysablehats/opensim-rt:$BRANCH
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
	winpty docker run --rm -it \
		-e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
		mysablehats/opensim-rt:$BRANCH


fi



