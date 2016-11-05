//
//  moive_info_imp.hpp
//  lapse
//
//  Created by dyno on 11/1/16.
//
//

#ifndef moive_info_imp_hpp
#define moive_info_imp_hpp

#include "moive_info_gen.hpp"
#include "macro.h"

namespace lpase {
    
    class MoiveInfoImp:public MoiveInfoGen {
    public:
        MoiveInfoImp(const std::string& name):m_name(std::move(name)),m_frame_amount(0),m_duration_second(0.0f),m_fps(0.0f),m_record_duration(0.0f),m_record_lapse(0.0f) {
            
        }
        virtual ~MoiveInfoImp() {}
        
        virtual std::string getName();
        
        virtual std::string getFileName();
        
        virtual int32_t getFrameAmount();
        
        virtual float getDurationSecond();
        
        virtual float getFPS();
        
        virtual float getRecordDuration();
        
        virtual float getRecordLapse();
        
        virtual bool setName(const std::string & name);
        
        virtual void setFrameAmount(int32_t amount);
        
        virtual void setDurationSecond(float seconds);
        
        virtual void setFPS(float fps);
        
        virtual void setRecordDuration(float duration);
        
        virtual void setRecordLapse(float lapse);
    private:
        std::string m_name;
        std::string m_file_name;
        int32_t m_frame_amount;
        float m_duration_second;
        float m_fps;
        float m_record_duration;
        float m_record_lapse;
    };
    
}  // namespace lpase

#endif /* moive_info_imp_hpp */
