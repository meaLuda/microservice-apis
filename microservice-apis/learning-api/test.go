package main

import (
	"fmt"
	"microLearningApi/models"
)

func Test_db_conntection_getCourses() {
	// Test connection result
	courses, err_ := models.GetCourses(10)

	checkErr(err_)

	if courses == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(courses)
	}
}

func Test_db_conntection_getLessons() {
	// Test connection result
	courses, err_ := models.GetLessons()

	checkErr(err_)

	if courses == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(courses)
	}
}

func Test_db_conntection_getRadioStationCategory() {
	// Test connection result
	stationCats, err_ := models.GetAllRadioStationCategories()

	checkErr(err_)

	if stationCats == nil {
		fmt.Println("No records found")
		return
	} else {
		// return records
		fmt.Println(stationCats)
	}
}