//
//  quick_mode_imp.cpp
//  lapse
//
//  Created by dyno on 10/10/16.
//
//

#include "quick_mode_imp.hpp"

using namespace lpase;

std::shared_ptr<QuickModeGen> QuickModeGen::create(const std::string & name, int32_t fps, int32_t interval){
    return std::make_shared<QuickModeImp>(name, fps, interval);
}
