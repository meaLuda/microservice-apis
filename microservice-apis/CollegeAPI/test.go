package main

import (
	"fmt"
	"collegeAPI/models"
)

func Test_db_conntection_getCourses() {
	// Test connection result
	courses, err_ := models.GetDepertments()

	checkErr(err_)

	if courses == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(courses)
	}
}

