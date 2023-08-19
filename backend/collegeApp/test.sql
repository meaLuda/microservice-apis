-- Active: 1692267762405@@127.0.0.1@3306

-- select all commands
SELECT * FROM "CollegeDepertment";

SELECT * FROM "CollegeDiploma";

SELECT * FROM "CollegeDiploma_Module";

SELECT * FROM "CollegeDiploma_Submodule";

SELECT * FROM "CollegeDiploma_SubmoduleContent_notes";



--- Select by specific depertment and module
--- select nursing -mental health
SELECT * FROM "CollegeDiploma_Module"
WHERE   diploma_id=32;

SELECT * FROM "CollegeDiploma_Submodule"
WHERE   diploma_id=32;

SELECT * FROM "CollegeDiploma_Submodule"
WHERE   diploma_id=32 AND module_id=4;

-- get notes
SELECT * FROM "CollegeDiploma_SubmoduleContent_notes"
WHERE   diploma_id=32 AND module_id=4 AND sub_module_id=35;