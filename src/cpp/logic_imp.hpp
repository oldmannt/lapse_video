//
//  logic_imp.hpp
//  lapse
//
//  Created by dyno on 7/27/16.
//
//

#ifndef logic_imp_hpp
#define logic_imp_hpp

#include "logic_gen.hpp"
#include "task_excuser_gen.hpp"
#include "task_info.hpp"
#include "video_writer_gen.hpp"
#include "config_gen.hpp"

namespace lpase {

class LogicImp: public LogicGen , public gearsbox::TaskExcuserGen, public std::enable_shared_from_this<LogicImp> {
public:
    virtual ~LogicImp() {}
    LogicImp();
    
    virtual bool initialize(const std::string & config);
    
    //gearsbox::TaskExcuserGen
    virtual void excuse(const gearsbox::TaskInfo & info);
    
private:
    std::shared_ptr<gearsbox::VideoWriterGen> m_video_writer;
    std::shared_ptr<gearsbox::ConfigGen> m_vide_config;
    std::shared_ptr<gearsbox::ConfigGen> m_camera_config;
    
    void captureStart();
    void capturePause();
    void captureResume();
    void captureStop();
    
    void initialize_camera();
    void initialize_video();
};
    
}

#endif /* logic_imp_hpp */
