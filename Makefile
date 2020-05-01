DEBUG=0
CXXFLAGS=-c -std=c++14 -Wall -Wpedantic -Wextra -Wshadow -Wdouble-promotion -Wold-style-cast
#LDFLAGS=-lopenssl
SOURCES=main.cpp
BASE_NAMES=$(basename $(SOURCES))
OBJECTS=$(BASE_NAMES:=.o)
DEPENDENCIES=$(OBJECTS:.o=.d)
EXECUTABLE=server

.PHONY: all
ifeq ($(DEBUG),1)
all: CXXFLAGS+=-DDEBUG -g
else
all: CXXFLAGS+=-O3
all: LDFLAGS+=-O3
endif
all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CXX) $(OBJECTS) $(LDFLAGS) -o $@

-include $(DEPENDENCIES)

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -MMD -MP $< -o $@


.PHONY: clean
clean:
	$(RM) $(EXECUTABLE) *.o *.d