//
//  moive_info_manager_imp.hpp
//  lapse
//
//  Created by dyno on 11/1/16.
//
//

#ifndef moive_info_manager_imp_hpp
#define moive_info_manager_imp_hpp

#include "moive_info_manager_gen.hpp"
#include "moive_info_gen.hpp"
#include "timer_gen.hpp"
#include <map>

namespace lpase {
    
    class MoiveInfoGen;
    
    class MoiveInfoManagerImp:public MoiveInfoManagerGen {
    public:
        virtual ~MoiveInfoManagerImp() {}
        
        static  std::shared_ptr<MoiveInfoManagerGen> instance();
        
        virtual bool initialize(const std::string & config);
        
        virtual std::shared_ptr<MoiveInfoGen> createMoiveInfo(const std::string & name);
        
        virtual std::shared_ptr<MoiveInfoGen> findMoiveInfo(const std::string & name);
        
        virtual void removeMoiveInfo(const std::string & name);
        
        virtual void save();
        
    private:
        typedef std::map<std::string, std::shared_ptr<MoiveInfoGen>> SET_MOIVE;
        SET_MOIVE m_moive_infos;
        std::string m_path;
        //gearsbox::TimerGen m_save_timer;
        
        std::shared_ptr<MoiveInfoGen> insertMoiveInfo(const std::string & name);
    };
    
}  // namespace lpase

#endif /* moive_info_manager_imp_hpp */
