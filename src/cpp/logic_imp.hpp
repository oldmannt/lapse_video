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
#include "task_info_gen.hpp"
#include "video_writer_gen.hpp"
#include "video_writer_result_handler.hpp"

namespace lpase {
class LogicImp: public LogicGen , public gearsbox::TaskExcuserGen, public gearsbox::VideoWriterResultHandler, public std::enable_shared_from_this<LogicImp> {
public:
    virtual ~LogicImp() {}
    LogicImp();
    
    virtual bool initialize(const std::string & config);
    virtual std::string getProjectsPath();
    
    virtual void captureStart();
    
    virtual void capturePause();
    
    virtual void captureResume();
    
    virtual void captureStop();
    
    virtual void lapseStop();
    
    virtual void lapseResume();
    
    //gearsbox::TaskExcuserGen
    virtual void excuse(const std::shared_ptr<gearsbox::TaskInfoGen> & info);
    
    //gearsbox::VideoWriterResultHandler
    virtual void onComplete(bool success, const std::string & path, int32_t duration);
    
    virtual void beforeComplete();
    
    virtual void onProgress(float percent);
    
private:
    std::shared_ptr<gearsbox::VideoWriterGen> m_video_writer;
    
    void initialize_camera();
    void initialize_video();
    void setCaptureInteral(int32_t interval);
    std::string genFileName();
};
    
}

#endif /* logic_imp_hpp */
