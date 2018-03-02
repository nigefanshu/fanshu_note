
ROOTSRC=$(wildcard *.cpp)
TARGETSRC1=test.cpp
TARGETSRC2=test2.cpp
src=$(filter-out $(TARGETSRC1) $(TARGETSRC2),$(ROOTSRC))   

#过滤掉带有main()  cpp文件

OBJ=$(patsubst %.cpp,%.o,$(src))
LIB=
FLAG=-g -o0 -Wall -std=c++11

#用all包装一下就可以一次编译出多个可执行文件
all:test test2

test:$(OBJ)
	g++ $(FLAG) -o test $(TARGETSRC1) $(OBJ)  $(LIB)
	@echo $(OBJ)
	
test2:$(OBJ)
	g++ $(FLAG) -o test2  $(TARGETSRC2) $(OBJ)  $(LIB) 
	
clean:
	rm *.o test test2
	@echo 'clean completed'
