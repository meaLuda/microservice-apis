package models

import (
	_ "github.com/mattn/go-sqlite3"
	"strconv"
)

// ----------------------------------------------  structs for college --------------------------------
type CollegeDepartmentFields struct {
	ID    int    `json:"id"`
	Title string `json:"title"`
}

type CollegeDiplomaFields struct {
	ID           int    `json:"id"`
	Title        string `json:"title"`
	DepertmentID int    `json:"depertment_id"`
}

type CollegeModuleFields struct {
	ID        int    `json:"id"`
	Title     string `json:"title"`
	DiplomaID int    `json:"diploma_id"`
}

type CollegeSubmoduleFields struct {
	ID        int    `json:"id"`
	Title     string `json:"title"`
	ModuleID  int    `json:"module_id"`
	DiplomaID int    `json:"diploma_id"`
}

type CollegeCourseContentFields struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Image       string `json:"image"`
	ExamPDF     string `json:"exam_pdf"`
	DiplomaID   int    `json:"diploma_id"`
	ModuleID    int    `json:"module_id"`
	SubModuleID int    `json:"sub_module_id"`
}

// Constant Table Names:
const collegeDepertmantTable string = "CollegeDepertment"
const collegeDiplomaTable string = "CollegeDiploma"
const collegeDiplomaModuleTable string = "CollegeDiploma_Module"
const collegeDipModuleContentTable string = "CollegeDiploma_Submodule"

// ---------------------------------------------- queries for college apps  --------------------------------
func GetDiplomaModule(diploma_id int) ([]CollegeModuleFields, error) {
	//query db
	// 	SELECT * FROM "CollegeDiploma_Module"
	// WHERE   diploma_id=32;
	rows, err := DB.Query("SELECT * FROM CollegeDiploma_Module WHERE diploma_id="+strconv.Itoa(diploma_id)+";")
	if err != nil {
		return nil, err
	}

	defer rows.Close()

	modules := make([]CollegeModuleFields, 0)

	for rows.Next() {
		// create instances to be appended
		singleModule := CollegeModuleFields{}
		err = rows.Scan(&singleModule.ID, &singleModule.Title, &singleModule.DiplomaID)

		if err != nil {
			return nil, err
		}

		modules = append(modules, singleModule)
	}

	err = rows.Err()

	if err != nil {
		return nil, err
	}

	return modules, err
}

func GetDiplomaSubModule_ModeID(diploma_id int, module_id int) ([]CollegeSubmoduleFields, error) {
	//query db
	// SELECT * FROM "CollegeDiploma_Submodule"
	// WHERE   diploma_id=32 AND module_id=4;
	rows, err := DB.Query("SELECT * FROM CollegeDiploma_Submodule WHERE diploma_id="+strconv.Itoa(diploma_id)+" AND module_id="+strconv.Itoa(module_id)+";")
	if err != nil {
		return nil, err
	}

	defer rows.Close()

	subModule := make([]CollegeSubmoduleFields, 0)

	for rows.Next() {
		// create instances to be appended
		singleSubModule := CollegeSubmoduleFields{}
		err = rows.Scan(&singleSubModule.ID, &singleSubModule.Title, &singleSubModule.DiplomaID,&singleSubModule.ModuleID)

		if err != nil {
			return nil, err
		}

		subModule = append(subModule, singleSubModule)
	}

	err = rows.Err()

	if err != nil {
		return nil, err
	}

	return subModule, err

}

func GetDiplomaSubModule(diploma_id int) ([]CollegeSubmoduleFields, error) {
	//query db
	// SELECT * FROM "CollegeDiploma_Submodule"
	// WHERE   diploma_id=32 AND module_id=4;
	rows, err := DB.Query("SELECT * FROM CollegeDiploma_Submodule WHERE diploma_id="+strconv.Itoa(diploma_id)+";")
	if err != nil {
		return nil, err
	}

	defer rows.Close()

	subModule := make([]CollegeSubmoduleFields, 0)

	for rows.Next() {
		// create instances to be appended
		singleSubModule := CollegeSubmoduleFields{}
		err = rows.Scan(&singleSubModule.ID, &singleSubModule.Title, &singleSubModule.DiplomaID,&singleSubModule.ModuleID)

		if err != nil {
			return nil, err
		}

		subModule = append(subModule, singleSubModule)
	}

	err = rows.Err()

	if err != nil {
		return nil, err
	}

	return subModule, err

}