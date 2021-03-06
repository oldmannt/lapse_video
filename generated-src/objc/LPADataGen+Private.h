// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "data_gen.hpp"
#include <memory>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@class LPADataGen;

namespace djinni_generated {

class DataGen
{
public:
    using CppType = std::shared_ptr<::lpase::DataGen>;
    using CppOptType = std::shared_ptr<::lpase::DataGen>;
    using ObjcType = LPADataGen*;

    using Boxed = DataGen;

    static CppType toCpp(ObjcType objc);
    static ObjcType fromCppOpt(const CppOptType& cpp);
    static ObjcType fromCpp(const CppType& cpp) { return fromCppOpt(cpp); }

private:
    class ObjcProxy;
};

}  // namespace djinni_generated

