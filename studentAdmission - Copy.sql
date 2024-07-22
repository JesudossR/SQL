create database studentAdmission

use studentAdmission;

CREATE TABLE Students (
    StudentID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) NOT NULL,
    Address NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL
);

use studentAdmission
CREATE PROCEDURE sp_StudentAdmissionCRUD
    @Operation NVARCHAR(10),
    @StudentID INT = NULL,
    @FirstName NVARCHAR(50) = NULL,
    @LastName NVARCHAR(50) = NULL,
    @DateOfBirth DATE = NULL,
    @Gender NVARCHAR(10) = NULL,
    @Address NVARCHAR(100) = NULL,
    @Email NVARCHAR(100) = NULL,
    @PhoneNumber NVARCHAR(15) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Operation = 'CREATE'
    BEGIN
        INSERT INTO Students (FirstName, LastName, DateOfBirth, Gender, Address, Email, PhoneNumber)
        VALUES (@FirstName, @LastName, @DateOfBirth, @Gender, @Address, @Email, @PhoneNumber);
    END
    ELSE IF @Operation = 'READ'
    BEGIN
        IF @StudentID IS NOT NULL
        BEGIN
            SELECT * FROM Students WHERE StudentID = @StudentID;
        END
        ELSE
        BEGIN
            SELECT * FROM Students;
        END
    END
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE Students
        SET FirstName = ISNULL(@FirstName, FirstName),
            LastName = ISNULL(@LastName, LastName),
            DateOfBirth = ISNULL(@DateOfBirth, DateOfBirth),
            Gender = ISNULL(@Gender, Gender),
            Address = ISNULL(@Address, Address),
            Email = ISNULL(@Email, Email),
            PhoneNumber = ISNULL(@PhoneNumber, PhoneNumber)
        WHERE StudentID = @StudentID;
    END
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM Students WHERE StudentID = @StudentID;
    END
    ELSE
    BEGIN
        PRINT 'Invalid Operation';
    END
END
GO

EXEC sp_StudentAdmissionCRUD
    @Operation = 'READ';

EXEC sp_StudentAdmissionCRUD
    @Operation = 'CREATE',
    @FirstName = 'John',
    @LastName = 'Doe',
    @DateOfBirth = '2000-01-01',
    @Gender = 'Male',
    @Address = '123 Main St',
    @Email = 'john.doe@example.com',
    @PhoneNumber = '123-456-7890';

	EXEC sp_StudentAdmissionCRUD
    @Operation = 'READ',
    @StudentID = 1;

	EXEC sp_StudentAdmissionCRUD
    @Operation = 'UPDATE',
    @StudentID = 1,
    @FirstName = 'Jesu',
    @LastName = 'R',
    @DateOfBirth = '2000-09-17',
    @Gender = 'Male',
    @Address = 'India',
    @Email = 'jesu@example.com',
    @PhoneNumber = '987-654-3210';

	EXEC sp_StudentAdmissionCRUD
    @Operation = 'DELETE',
    @StudentID = 1;

	---------users signup
	drop table users

	CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(50) NOT NULL,
    Password NVARCHAR(256) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    CreatedDate DATETIME DEFAULT GETDATE()
);
GO

CREATE PROCEDURE sp_UserCRUD
    @Operation NVARCHAR(10),
    @UserID INT = NULL,
    @UserName NVARCHAR(50) = NULL,
    @Password NVARCHAR(256) = NULL,
    @Email NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    IF @Operation = 'CREATE'
    BEGIN
        INSERT INTO Users (UserName, Password, Email)
        VALUES (@UserName, @Password, @Email);
    END
    ELSE IF @Operation = 'READ'
    BEGIN
        IF @UserID IS NOT NULL
        BEGIN
            SELECT * FROM Users WHERE UserID = @UserID;
        END
        ELSE
        BEGIN
            SELECT * FROM Users;
        END
    END
    ELSE IF @Operation = 'UPDATE'
    BEGIN
        UPDATE Users
        SET UserName = ISNULL(@UserName, UserName),
            Password = ISNULL(@Password, Password),
            Email = ISNULL(@Email, Email)
        WHERE UserID = @UserID;
    END
    ELSE IF @Operation = 'DELETE'
    BEGIN
        DELETE FROM Users WHERE UserID = @UserID;
    END
    ELSE
    BEGIN
        PRINT 'Invalid Operation';
    END
END
GO

EXEC sp_UserCRUD
    @Operation = 'CREATE',
    @UserName = 'Ravi',
    @Password = 'password123',
    @Email = 'ravi@example.com';

EXEC sp_UserCRUD
    @Operation = 'READ';

EXEC sp_UserCRUD
    @Operation = 'READ',
    @UserID = 1;

EXEC sp_UserCRUD
    @Operation = 'UPDATE',
    @UserID = 1,
    @UserName = 'Ravivarma',
    @Password = 'password456',
    @Email = 'Ravivarma@example.com';

EXEC sp_UserCRUD
    @Operation = 'DELETE',
    @UserID = 1;
