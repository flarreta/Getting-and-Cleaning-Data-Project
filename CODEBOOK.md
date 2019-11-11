\#Coursera *Getting and Cleaning Data* course project

Francisco Larreta
-----------------

The 5 steps of this project are performed by the document in the
`run_analysis.R` script.

Files and Folder
----------------

The files used with the script was downloaded from
`Final Project Dataset`.

Variables
---------

-   `features` &lt;- `features.txt`: The features selected for this
    database come from the accelerometer and gyroscope 3-axial raw
    signals tAcc-XYZ and tGyro-XYZ.
-   `activities` &lt;- `activity_labels.txt`: List of activities
    performed when the corresponding measurements were taken and its
    codes (labels)
-   `subject_test` &lt;- `test/subject_test.txt`: Test data of 9/30
    volunteer test ubjects being observed
-   `x_test` &lt;- `test/X_test.txt`: Recorded features test data
-   `y_test` &lt;- `test/y_test.txt`: Test data of activities’code
    labels
-   `subject_train` &lt;- `test/subject_train.txt`: Train data of 21/30
    volunteer subjects being observed
-   `x_train` &lt;- `test/X_train.txt`: Recorded features train data
-   `y_train` &lt;- `test/y_train.txt`: Train data of activities’code
    labels

Step 1:
-------

-   `X` is created by merging `x_train` and `x_test` using rbind()
    function
-   `Y` is created by merging `y_train` and `y_test` using rbind()
    function
-   `Subject` is created by merging `subject_train` and `subject_test`
    using rbind() function
-   `Merged_Data` is created by merging `Subject`, `Y` and `X` using
    cbind() function

Step 2:
-------

-   `Tidy_Data` is created by subsetting `Merged_Data`, selecting only
    columns: subject, code and the measurements on the mean and standard
    deviation (std) for each measurement

Step 3:
-------

-   Entire numbers in code column of the `Tidy_Data` replaced with
    corresponding activity taken from second column of the activities
    variable

Step 4:
-------

-   All `Acc` in column’s name was replaced with `Accelerometer`
-   All `Gyro` in column’s name was replaced with `Gyroscope`
-   All `BodyBody` in column’s name was replaced with `Body`
-   All `Mag` in column’s name was replaced with `Magnitude`
-   All start with character `f` in column’s name was replaced with
    `Frequency`
-   All start with character `t` in column’s name was replaced with
    `Time`

Step 5:
-------

-   `Final_Data` is created by sumarizing `Tidy_Data` taking the means
    of each variable for each activity and each subject, after groupped
    by subject and activity.

-   Export `Final_Data` into `Final_Data.txt` file.
