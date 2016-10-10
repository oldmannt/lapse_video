//
//  data_imp.hpp
//  lapse
//
//  Created by dyno on 8/28/16.
//
//

#ifndef data_imp_hpp
#define data_imp_hpp

#include "data_gen.hpp"
#include "config_gen.hpp"

namespace lpase {
    
class DataImp: public DataGen {
public:
    virtual ~DataImp() {}
    
    static std::shared_ptr<DataGen> instance();
    
    virtual bool initialize(const std::string & config);
    
    virtual std::string getProjectsDir();
    
    virtual std::string getCaptureMode();
    
    virtual void setCaptureMode(const std::string & mode);
    
    virtual int32_t getCaptureIntevalMillsec();
    
    virtual int32_t getCaptureInteval();
    
    virtual std::string getCaptureIntevalUnit();
    
    virtual void setCaptureInteval(int32_t value, const std::string & unit);
    
    virtual void setCaptureIntervalQuickMode(const std::string & mode);
    
    virtual std::string getCaptureIntervalQuickMode();
    
    virtual int32_t getFps();
    
    virtual int32_t getBitrate();
    
    virtual int32_t getResolution();
    
    virtual void setFps(int32_t fps);
    
    virtual void setBitrate(int32_t bitrate);
    
    virtual void setResolution(int32_t reso);
    
    virtual bool isCaptureModePhoto(int32_t interal);
    
    virtual bool isCaptureImmediate(int32_t interal);
private:
    std::shared_ptr<gearsbox::ConfigGen> m_user_config;
    std::shared_ptr<gearsbox::ConfigGen> m_vide_config;
    std::shared_ptr<gearsbox::ConfigGen> m_camera_config;
};
    
}  // namespace lpase


#endif /* data_imp_hpp */
