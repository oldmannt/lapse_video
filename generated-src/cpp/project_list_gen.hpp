// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from lapse.djinni

#pragma once

#include <cstdint>
#include <memory>

namespace lpase {

class ProjectCellGen;
enum class PublishChannel;

class ProjectListGen {
public:
    virtual ~ProjectListGen() {}

    static std::shared_ptr<ProjectListGen> instance();

    virtual bool load(int32_t review_w, int32_t review_h) = 0;

    virtual int32_t getProjectAmount() = 0;

    virtual std::shared_ptr<ProjectCellGen> getProjectData(int32_t index) = 0;

    virtual void selectProject(int32_t index) = 0;

    virtual void deleteProject(int32_t index) = 0;

    virtual void publishProject(int32_t index, PublishChannel channel) = 0;

    virtual void saveProject(int32_t index) = 0;

    virtual void watchProject(int32_t index) = 0;
};

}  // namespace lpase
