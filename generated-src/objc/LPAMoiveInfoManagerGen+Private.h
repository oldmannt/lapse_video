// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "moive_info_manager_gen.hpp"
#include <memory>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@class LPAMoiveInfoManagerGen;

namespace djinni_generated {

class MoiveInfoManagerGen
{
public:
    using CppType = std::shared_ptr<::lpase::MoiveInfoManagerGen>;
    using CppOptType = std::shared_ptr<::lpase::MoiveInfoManagerGen>;
    using ObjcType = LPAMoiveInfoManagerGen*;

    using Boxed = MoiveInfoManagerGen;

    static CppType toCpp(ObjcType objc);
    static ObjcType fromCppOpt(const CppOptType& cpp);
    static ObjcType fromCpp(const CppType& cpp) { return fromCppOpt(cpp); }

private:
    class ObjcProxy;
};

}  // namespace djinni_generated

