.PHONY: all clean

TARGETS = yuv2rgb_opencv \
			imshow \
			topk \
			reinterpret_cast \
			generate_yuv2rgb_table

all: $(TARGETS)

# ======================================================
generate_yuv2rgb_table: generate_yuv2rgb_table.o
	g++ -o $@ $^

generate_yuv2rgb_table.o: generate_yuv2rgb_table.cpp
	g++ -std=c++11 -c $< $^

# ======================================================
# refer to : pkg-config opencv --libs
CVLIB = -lopencv_calib3d -lopencv_contrib \
		-lopencv_core -lopencv_features2d \
		-lopencv_flann -lopencv_gpu \
		-lopencv_highgui -lopencv_imgproc \
		-lopencv_legacy -lopencv_ml \
		-lopencv_photo -lopencv_video 

yuv2rgb_opencv: yuv2rgb_opencv.o
	g++ -o $@ $^ $(CVLIB)

yuv2rgb_opencv.o: yuv2rgb_opencv.cpp
	g++ -c $< $^

# ======================================================
imshow: imshow.o
	g++ -o $@ $^ $(CVLIB)

imshow.o: imshow.cpp
	g++ -c $< $^

# ======================================================
topk: topk.o
	g++ -o $@ $^

topk.o: topk.cpp
	g++ -c -std=c++11 $< $^


# ======================================================
reinterpret_cast: reinterpret_cast.o
	g++ -o $@ $^

reinterpret_cast.o: reinterpret_cast.cpp
	g++ -c -std=c++11 $< $^

clean:
	rm -f a.out
	rm -f *.o
	rm -f $(TARGETS)
