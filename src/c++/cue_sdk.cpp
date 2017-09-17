#include "cue_sdk.h"
#include "CUESDK.h"
#include <cassert>
#include <cstdio>

namespace
{

const char* corsair_error_to_string[] =
{
    "Success",
    "ServerNotFound",
    "NoControl",
    "ProtocolHandshakeMissing",
    "IncompatibleProtocol",
    "InvalidArguments"
};

class cue_global
{
public:
    static void init()
    {
        assert(references_ >= 0);
        if (references_ == 0)
        {
            CorsairProtocolDetails detail = CorsairPerformProtocolHandshake();
            CorsairError error = CorsairGetLastError();
            if (error != CE_Success)
            {
                std::printf("An error occurred: %s\n", corsair_error_to_string[error]);
            }
            references_++;
        }
    }

    static void quit()
    {
        assert(references_ >= 0);
        references_--;
    }

private:
    static int references_;
};

int cue_global::references_ = 0;

}

namespace nlrs
{

cue_sdk::cue_sdk()
{
    cue_global::init();
}

cue_sdk::~cue_sdk()
{
    cue_global::quit();
}

}
