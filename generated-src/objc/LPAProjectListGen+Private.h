// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#include "project_list_gen.hpp"
#include <memory>

static_assert(__has_feature(objc_arc), "Djinni requires ARC to be enabled for this file");

@class LPAProjectListGen;

namespace djinni_generated {

class ProjectListGen
{
public:
    using CppType = std::shared_ptr<::lpase::ProjectListGen>;
    using CppOptType = std::shared_ptr<::lpase::ProjectListGen>;
    using ObjcType = LPAProjectListGen*;

    using Boxed = ProjectListGen;

    static CppType toCpp(ObjcType objc);
    static ObjcType fromCppOpt(const CppOptType& cpp);
    static ObjcType fromCpp(const CppType& cpp) { return fromCppOpt(cpp); }

private:
    class ObjcProxy;
};

}  // namespace djinni_generated

