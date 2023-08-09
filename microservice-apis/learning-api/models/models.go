package models

import (
	"strconv"
	_ "github.com/mattn/go-sqlite3"
)

// ----------------------------------------------  structs for learning --------------------------------
type Course struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
}

type Lesson struct {
	ID          int    `json:"id"`
	Title       string `json:"title"`
	Description string `json:"description"`
	CourseID    int    `json:"course_id"`
}

type Content struct {
	ID          int    `json:"id"`
	ContentType string `json:"content_type"`
	Content     string `json:"content"`
	LessonID    int    `json:"lesson_id"`
}


// ---------------------------------------------- queries for learning  --------------------------------

// Queries db for courses
func GetCourses(count int) ([]Course, error) {
	//query db
	rows, err := DB.Query("SELECT * FROM course_table LIMIT " + strconv.Itoa(count))
	if err != nil {
		return nil, err
	}

	defer rows.Close()

	courses := make([]Course, 0)

	for rows.Next() {
		// create instances to be appended
		singleCourse := Course{}
		err = rows.Scan(&singleCourse.ID, &singleCourse.Title, &singleCourse.Description)

		if err != nil {
			return nil, err
		}

		courses = append(courses, singleCourse)
	}

	err = rows.Err()

	if err != nil {
		return nil, err
	}

	return courses, err
}


// GetLessons queries the database for lessons
func GetLessons() ([]Lesson, error) {
	rows, err := DB.Query("SELECT * FROM lesson_table") // Change '10' to the desired limit

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	lessons := make([]Lesson, 0)

	for rows.Next() {
		singleLesson := Lesson{}
		err = rows.Scan(&singleLesson.ID, &singleLesson.Title, &singleLesson.Description, &singleLesson.CourseID)

		if err != nil {
			return nil, err
		}

		lessons = append(lessons, singleLesson)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return lessons, nil
}

// GetContents queries the database for contents of a lesson
func GetContents(lessonID int) ([]Content, error) {
	rows, err := DB.Query("SELECT * FROM content_table WHERE lesson_id = ?", lessonID)

	if err != nil {
		return nil, err
	}

	defer rows.Close()

	contents := make([]Content, 0)

	for rows.Next() {
		singleContent := Content{}
		err = rows.Scan(&singleContent.ID, &singleContent.ContentType, &singleContent.Content, &singleContent.LessonID)

		if err != nil {
			return nil, err
		}

		contents = append(contents, singleContent)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return contents, nil
}

// GetCourseByID queries the database for a course with a specific ID
func GetCourseByID(courseID int) (Course, error) {
	row := DB.QueryRow("SELECT * FROM course_table WHERE id = ?", courseID)

	course := Course{}

	err := row.Scan(&course.ID, &course.Title, &course.Description)
	if err != nil {
		return Course{}, err
	}

	return course, nil
}

// GetLessonByID queries the database for a lesson with a specific ID
func GetLessonByID(lessonID int) (Lesson, error) {
	row := DB.QueryRow("SELECT * FROM lesson_table WHERE id = ?", lessonID)

	lesson := Lesson{}

	err := row.Scan(&lesson.ID, &lesson.Title, &lesson.Description, &lesson.CourseID)
	if err != nil {
		return Lesson{}, err
	}

	return lesson, nil
}


// ----------------------------------------------  structs for radio  --------------------------------
// RadioStationCategory represents the Golang equivalent of the Django RadioStationCategory model.
type RadioStationCategory struct {
	ID           int    `json:"id"`
	Name         string `json:"name"`
	BannerImgURL string `json:"banner_img_link"`
}

// RadioStation represents the Golang equivalent of the Django RadioStation model.
type RadioStation struct {
	ID         int    `json:"id"`
	Name       string `json:"name"`
	About      string `json:"about"`
	ImgURL     string `json:"img_link"`
	StreamURL  string `json:"stream_url"`
	CategoryID int    `json:"category_id"` // Foreign key representing the category ID
}

func GetAllRadioStationCategories() ([]RadioStationCategory, error) {
	query := "SELECT * FROM radiostation_category_table"
	rows, err := DB.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	categories := make([]RadioStationCategory, 0)

	for rows.Next() {
		category := RadioStationCategory{}
		err := rows.Scan(&category.ID, &category.Name, &category.BannerImgURL)
		if err != nil {
			return nil, err
		}

		categories = append(categories, category)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return categories, nil
}

func GetRadioStationCategoryByID(id int) (RadioStationCategory, error) {
	query := "SELECT * FROM radiostation_category_table WHERE id = ?"
	row := DB.QueryRow(query, id)

	category := RadioStationCategory{}
	err := row.Scan(&category.ID, &category.Name, &category.BannerImgURL)
	if err != nil {
		return RadioStationCategory{}, err
	}

	return category, nil
}


func GetAllRadioStations() ([]RadioStation, error) {
	query := "SELECT * FROM radio_station_table"
	rows, err := DB.Query(query)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	stations := make([]RadioStation, 0)

	for rows.Next() {
		station := RadioStation{}
		err := rows.Scan(&station.ID, &station.Name, &station.About, &station.ImgURL, &station.StreamURL, &station.CategoryID)
		if err != nil {
			return nil, err
		}

		stations = append(stations, station)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return stations, nil
}


func GetRadioStationByID(id int) (RadioStation, error) {
	query := "SELECT * FROM radio_station_table WHERE id = ?"
	row := DB.QueryRow(query, id)

	station := RadioStation{}
	err := row.Scan(&station.ID, &station.Name, &station.About, &station.ImgURL, &station.StreamURL, &station.CategoryID)
	if err != nil {
		return RadioStation{}, err
	}

	return station, nil
}