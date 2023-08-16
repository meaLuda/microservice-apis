package models

import (
	"strconv"
	_ "github.com/mattn/go-sqlite3"
)

// ----------------------------------------------  structs for college --------------------------------
type CollegeDepartmentFields struct {
	ID    int    `json:"id"`
    Title string `json:"title"`
}

type CollegeDiplomaFields struct {
	ID          int    `json:"id"`
    Title      string `json:"title"`
	DepertmentID    int    `json:"depertment_id"`
}

type CollegeModuleFields struct {
	ID		int    `json:"id"`
    Title   string `json:"title"`
	DiplomaID    int    `json:"diploma_id"`
}

type CollegeSubmoduleFields struct {
    ID      int    `json:"id"`
    Title   string `json:"title"`
	ModuleID    int    `json:"module_id"`
	DiplomaID    int    `json:"diploma_id"`
}

type CollegeCourseContentFields struct {
	ID          int    `json:"id"`
    Title     string `json:"title"`
    Image     string `json:"image"`
    ExamPDF   string `json:"exam_pdf"`
	DiplomaID    int    `json:"diploma_id"`
	ModuleID     int    `json:"module_id"`
	SubModuleID  int    `json:"sub_module_id"`
}

// Constant Table Names:
const collegeDepertmantTable string = "CollegeDepertment"
const collegeDiplomaTable string = "CollegeDiploma"
const collegeDiplomaModuleTable string = "CollegeDiploma_Module"
const collegeDipModuleContentTable string = "CollegeDiploma_SubmoduleContent"

// ---------------------------------------------- queries for learning  --------------------------------

// ------------> Get All 
// Queries db for courses
func GetDepertments() ([]CollegeDepartmentFields, error) {
	//query db
	rows, err := DB.Query("SELECT * FROM "+ collegeDepertmantTable +" LIMIT")
	if err != nil {
		return nil, err
	}

	defer rows.Close()

	departments := make([]CollegeDepartmentFields, 0)

	for rows.Next() {
		// create instances to be appended
		singleDepertment := CollegeDepartmentFields{}
		err = rows.Scan(&singleDepertment.ID, &singleDepertment.Title)

		if err != nil {
			return nil, err
		}

		departments = append(departments, singleDepertment)
	}

	err = rows.Err()

	if err != nil {
		return nil, err
	}

	return departments, err
}