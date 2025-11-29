DELIMITER $$
DROP PROCEDURE IF EXISTS `sp_EvaluateStudentPerformance`$$
CREATE DEFINER = `root`@`localhost` PROCEDURE `sp_EvaluateStudentPerformanceCourse` (
	IN p_CourseID INT, 
    IN p_minAvgScore FLOAT, 
    IN p_minCompletionRate FLOAT 
)

BEGIN 
	SELECT 
		S.ID AS StudentID, 
        CONCAT (U.First_Name, ' ', U.Last_Name) AS StudentName,
		U.Email AS StudentEmail, 
        C.Title AS CourseTitle, 

        tq.Total_Quizzes AS Total_Quizzes, 
        
        COUNT(DISTINCT b.Learning_Item_ID) AS Quizzes_Taken,
        
        ROUND(
            COUNT(DISTINCT b.Learning_Item_ID) / tq.Total_Quizzes, 
            2
        ) AS Completion_Rate,
        
        ROUND(AVG(b.BestScore), 2) AS Average_Best_Score,
        
        MAX(b.BestScore) AS Max_Best_Score,
        MIN(b.BestScore) AS Min_Best_Score,
        
        
         SEC_TO_TIME(
            COALESCE(
                SUM(
                    TIME_TO_SEC(b.Total_Time_On_Quiz)
                ), 
                0
            )
        ) AS Total_Time_On_Quizzes
        
    FROM 
		Course C 
	JOIN Enrollment E 
			ON E.Course_ID = C.ID 
	JOIN Student S
			ON S.ID = E.Student_ID
	JOIN Users U 
			ON U.ID = S.ID 
		
	JOIN Learning_Item LI 
			ON LI.Content_Type = 'QUIZ'
            AND LI.Course_ID = C.ID 
	
    JOIN (
		SELECT Course_ID, 
		COUNT(*) AS Total_Quizzes
		FROM Learning_Item 
        WHERE Content_Type = 'QUIZ'
        GROUP BY Course_ID
    ) AS tq 
		ON tq.Course_ID = C.ID 
	
    
    LEFT JOIN (
		SELECT 
			mp.Enroll_ID, 
            mp.Learning_Item_ID, 
            mp.Learning_Item_Course_ID, 
            mp.Learning_Item_Module_Title, 
            max(mp.score) AS BestScore, 
            SEC_TO_TIME(
				SUM(
					TIME_TO_SEC(mp.Completion_Time)
                )
            ) AS Total_Time_On_Quiz
		FROM Make_Progress mp 
        GROUP BY 
			mp.Enroll_ID, 
            mp.Learning_Item_ID, 
            mp.Learning_Item_Course_ID, 
            mp.Learning_Item_Module_Title
    ) AS b 
		ON 
				b.Enroll_ID = E.Enroll_ID 
            AND b.Learning_Item_ID = LI.ID
            AND b.Learning_Item_Course_ID = LI.Course_ID
            AND b.Learning_Item_Module_Title = LI.Module_Title
	
	WHERE 
		C.ID = p_CourseID 
        AND (C.Course_Status IS NULL OR C.Course_Status <> 'Discarded' )
	GROUP BY 
		S.ID, 
        StudentName, 
        U.EMail, 
        C.Title, 
        tq.Total_Quizzes
	HAVING 
		AVG(b.BestScore) >= p_minAvgScore
        AND (COUNT(DISTINCT b.Learning_Item_ID) / NULLIF(tq.Total_Quizzes, 0)) >= p_MinCompletionRate
        
    ORDER BY 
        Average_Best_Score DESC,
        Completion_Rate     DESC;

END $$

DELIMITER ; 