//
//  project_list_imp.hpp
//  lapse
//
//  Created by dyno on 8/14/16.
//
//

#ifndef project_list_imp_hpp
#define project_list_imp_hpp

#include "project_list_gen.hpp"
#include <vector>
#include <unordered_set>
#include <string>

namespace lpase {
    
    class ProjectCellGen;
    
    class ProjectListImp:public ProjectListGen {
    public:
        ProjectListImp():m_select(0){
            
        }
        virtual ~ProjectListImp() {}
        
        virtual bool load(int32_t review_w, int32_t review_h);
        
        virtual int32_t getProjectAmount(){
            return (int32_t)m_project_cells.size();
        }
        
        virtual std::shared_ptr<ProjectCellGen> getProjectData(int32_t index);
        
        virtual void selectProject(int32_t index);
        
        virtual void deleteProject(int32_t index);
        
        virtual void publishProject(int32_t index, PublishChannel channel);
        
        virtual void saveProject(int32_t index);
        
        virtual void watchProject(int32_t index);
        
    private:
        typedef std::vector<std::shared_ptr<ProjectCellGen>> VEC_CELLS;
        typedef std::unordered_set<std::string> SET_CELLS_PATH;
        VEC_CELLS m_project_cells;
        SET_CELLS_PATH m_project_paths;
        
        int32_t m_select;
    };
    
}  // namespace lpase


#endif /* project_list_imp_hpp */
