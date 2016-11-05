//
//  project_cell_imp.hpp
//  lapse
//
//  Created by dyno on 8/14/16.
//
//

#ifndef project_cell_imp_hpp
#define project_cell_imp_hpp

#include "project_cell_gen.hpp"
#include "video_info_gen.hpp"

namespace lpase {
    
    class ProjectCellImp:public ProjectCellGen {
    public:
        virtual ~ProjectCellImp() {}
        
        virtual std::string getPath(){ return m_path;}
        
        virtual std::string getName(){
            return m_name;
        }
        
        virtual std::string getCreateTime(){return m_create_time;}
        
        virtual std::string getLength(){return m_length;}
        
        virtual std::string getFps(){return m_fps;}
        
        virtual std::string getRecordDuration(){return m_record_duration;};
        
        bool initializ(const std::string& path, int out_w, int out_h);
        
        void setPath(std::string path){
            m_path = path;
        }
        
        void setName(std::string name){
            m_name = name;
        }
        
        void setCreateTime(std::string create_time){
            m_create_time = create_time;
        }
        
        void setFps(std::string fps){
            m_fps = fps;
        }
        
    private:
        std::string m_path;
        std::string m_name;
        std::string m_create_time;
        std::string m_length;
        std::string m_fps;
        std::string m_record_duration;
        std::shared_ptr<gearsbox::VideoInfoGen> m_video_info;
    };
    
}  // namespace lpase

#endif /* project_cell_imp_hpp */
