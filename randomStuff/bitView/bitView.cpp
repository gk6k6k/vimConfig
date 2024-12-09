#include <cstddef>
#include <cstdint>
#include <iostream>
#include  <iomanip>
#include "gtest/gtest.h"

void printByte(unsigned char* data, size_t size)
{
    std::cout<<"0x";
    for(size_t i = 0; i < size; i++)
    {
        std::cout<<std::hex<< std::setfill('0') << std::setw(2) << (int)data[i];
    }
//    std::cout<<std::endl;
//
    std::cout<<"    ";

    for(size_t i = 0; i < size; i++)
    {
        for (size_t j = 0; j < 8; j++)
        {
            std::cout<<((data[i] & (1 << j)) ? 1 : 0);
        }
        std::cout<<" ";
//        std::cout<<std::hex<< std::setfill('0') << std::setw(2) << (int)data[i];
    }
    std::cout<<std::endl;

}

template <size_t start, size_t size>
class Field {
public:
    static_assert(size <= 64);
    static_assert(size > 0);

    constexpr static size_t offset = start + size;

    Field(unsigned char* data) : data(data) {
    }

    void setValue(uint64_t value)
    {
        size_t lastByte = (start+size) % 8 ? ((start+size) / 8) + 1 : (start+size) / 8;
        lastByte--;

        unsigned char maskByte = 0xFF;
        maskByte = maskByte << ((start+size) % 8);
//        printByte(&maskByte, 1);
        data[lastByte] = data[lastByte] & maskByte;
//        printByte(&data[0], 3);
        unsigned char tmp = value;
        //unsigned char val = tmp >> ((start+size) % 8);
        unsigned char val = tmp >> (8 - ((start+size) % 8));
//        std::cout<< "bv:"; printByte(&val, 1);
        data[lastByte] = data[lastByte] | val;
        value = value >> ((start+size) % 8);

        lastByte--;
        maskByte = 0x00;
        data[lastByte] = data[lastByte] & maskByte;
        val = value;
        data[lastByte] = data[lastByte] | val;
//        value = value >> 8;


        lastByte--;
        maskByte = 0xFF;
        maskByte = maskByte >> (8 - ((start) % 8));
        printByte(&maskByte, 1);
        data[lastByte] = data[lastByte] & maskByte;
        val = value; // & maskByte;;
        data[lastByte] = data[lastByte] | val;
    }

    uint64_t value()
    {
        return 0;
    }
private:
    unsigned char* data;
};

template <typename f1, size_t size>
class Fieldw : public Field<f1::start + f1::size, size> {
};

class TransportStramPacketHeader {
public:
    Field<6, 6> tmp;
    Field<0, 8> sync_byte;
    Field<8, 1> transport_error_indicator;
    Field<9, 1> payload_unit_start_indicator;
    Field<10, 1> transport_priority;
    Field<11, 13> PID;
    Field<24, 2> transport_scrambling_control;
    Field<26, 2> adaptation_field_control;
    Field<28, 4> continuity_counter;

    TransportStramPacketHeader(unsigned char* data) : tmp(data), sync_byte(data), transport_error_indicator(data), payload_unit_start_indicator(data), transport_priority(data), PID(data), transport_scrambling_control(data), adaptation_field_control(data), continuity_counter(data) {}
};

struct Tests {
    Field<0, 6> a;
    Field<6, 12> b;
    Field<18, 24> c;

    Tests(unsigned char* data) : a(data), b(data), c(data) {
    }
};

TEST(KOKOSZKA, koko) {
    unsigned char data[3] = {0xFF, 0xFF, 0xFF};
    Tests t(data);
    t.b.setValue(0x0AAA);

    printByte((unsigned char*)data, 3);

    EXPECT_EQ(data[0], 0xbf);
    EXPECT_EQ(data[1], 0xaa);
    EXPECT_EQ(data[2], 0xfe);
}

TEST(KOKOSZKA, koko2) {
    unsigned char data[3] = {0x00, 0x00, 0x00};
    Tests t(data);
    t.b.setValue(0x0AAA);

    printByte((unsigned char*)data, 3);

    EXPECT_EQ(data[0], 0xfd);
    EXPECT_EQ(data[1], 0xaa);
    EXPECT_EQ(data[2], 0x7f);
}


//int main() {
//    //unsigned char data[3] = {0x00, 0x00, 0x00};
//    unsigned char data[3] = {0xFF, 0xFF, 0xFF};
//    Tests t(data);
//    t.b.setValue(0x0AAA);
//
//    printByte((unsigned char*)data, 3);
//
////    unsigned char data[8] = {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF};
////    TransportStramPacketHeader header(data);
////    header.tmp.setValue(7);
////    printByte(data, 8);
////    std::cout<<std::endl;
//}
