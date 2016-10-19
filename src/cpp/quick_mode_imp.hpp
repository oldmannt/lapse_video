//
//  quick_mode_imp.hpp
//  lapse
//
//  Created by dyno on 10/10/16.
//
//

#ifndef quick_mode_imp_hpp
#define quick_mode_imp_hpp

#include "quick_mode_gen.hpp"

namespace lpase {
    
    class QuickModeImp: public QuickModeGen {
    public:
        QuickModeImp(std::string name, int32_t fps, int32_t interval)
        :m_name(std::move(name)), m_interval(std::move(interval)), m_fps(std::move(fps)){
            
        }
        virtual ~QuickModeImp() {}

        virtual std::string getName(){return m_name;}
        
        virtual int32_t getFps(){return m_interval;}
        
        virtual int32_t getInterval(){return m_fps;}
        
    private:
        std::string m_name;
        int32_t m_interval;
        int32_t m_fps;
    };
    
}  // namespace lpase

#endif /* quick_mode_imp_hpp */
