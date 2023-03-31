#include "spdlog/spdlog.h"
#include <chrono>
#include <condition_variable>
#include <mutex>
#include <thread>

using namespace std::chrono_literals;
using namespace spdlog;

struct SerivceA {
    struct Helper {
        SerivceA &serviceA;
    };

    SerivceA() {
        info("ctorA");
    }
    void job() {
        info("start");
        for(const auto i : {1, 2, 3, 4, 5}) {
            info("working A");
            std::this_thread::sleep_for(100ms);
        }
        info("working A");
        spdlog::info("end");
    }
};

struct SerivceB {
    struct Helper {
        SerivceB &serviceB;
    };

    SerivceB() {
        info("ctorB");
    }
    void job() {
        info("start");
        for(const auto i : {1, 2, 3, 4, 5}) {
            info("working B");
            std::this_thread::sleep_for(100ms);
        }
        info("working B");
        spdlog::info("end");
    }
};

struct SerivceC {
    struct Helper {
        SerivceC &serviceC;
    };

    SerivceC() {
        info("ctorC");
    }
    void job() {
        info("start");
        for(const auto i : {1, 2, 3, 4, 5}) {
            info("working C");
            std::this_thread::sleep_for(100ms);
        }
        info("working C");
        spdlog::info("end");
    }
};

//===

struct SericeRepo;

template <typename... Ts>
struct Bundle;

template <>
struct Bundle<> {
    Bundle<>() {
    }
    Bundle<>(SericeRepo &) {
    }
};

struct SericeRepo : public SerivceC, public SerivceB, public SerivceA {
    template <typename... Ts>
    Bundle<Ts...> get() {
        return {*this};
    }
};

template <typename T, typename... Ts>
struct Bundle<T, Ts...> : public T::Helper, public Bundle<Ts...> {
    Bundle<T, Ts...>(SericeRepo &r) : T::Helper{r}, Bundle<Ts...>(r) {
    }
};

int main(int argc, char *argv[]) {
    spdlog::set_pattern("[%H:%M:%S %z] [%n] [%^---%L---%$] [thread %t] %v");

    std::mutex lock;
    std::condition_variable cv;

    SericeRepo r;
    auto x = r.get<SerivceC>();
    x.serviceC.job();

    auto y = r.get<SerivceA, SerivceC>();

    y.serviceA.job();
    y.serviceC.job();

    //    auto y = r.get<SerivceA> get();
    //    y.serviceA.job();

    //    auto xx = Bundle<SerivceA>;
    //    auto xx = Bundle<SerivceA>();

    //    auto xx = r.getServiceM<SerivceA, SerivceC>();
    //    xx.serviceC.job();
    //
    //
    //
    //
    //
    //    auto t2 = std::thread([&] {
    //        spdlog::info("start");
    //        std::unique_lock<std::mutex> ul(lock);
    //        for(const auto i : {1,2,3,4,5}) {
    //            std::this_thread::sleep_for(100ms);
    //            info("working a");
    //        }
    //        spdlog::info("end");
    //        cv.notify_one();
    //    });
    //
    //    std::this_thread::sleep_for(200ms);
    //
    //    auto t1 = std::thread([&] {
    //        spdlog::info("start");
    //        std::unique_lock<std::mutex> ul(lock);
    //        info("locked");
    //        cv.wait(ul);
    //        for(const auto i : {1,2,3,4,5}) {
    //            std::this_thread::sleep_for(100ms);
    //            spdlog::info("working b");
    //        }
    //        spdlog::info("end");
    //    });
    //
    //
    //    t1.join();
    //    t2.join();

    spdlog::info("end.");
    return 0;
}
