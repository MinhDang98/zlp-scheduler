require 'rails_helper'

describe "Scheduler" do
    before do
        @cohort = Cohort.new
            @cohort.save
        @user = User.new
            @user.firstname = 'Kylie'
            @user.lastname = 'Brown'
            @user.uin = 424242
            @user.email = 'kyliebrown@tamu.edu'
            @user.role = 'student'
            @user.password = "Temp"
            @user.cohort_id = 1
            @user.save
        @course = Course.new
            @course.abbreviated_subject = "TEST"
            @course.course_number = 210
            @course.section_number = 501
            @course.meetingtime_start = DateTime.new(2001,2,3,11,5,6,'-05:00')
            @course.meetingtime_end =   DateTime.new(2001,2,3,13,5,6,'-05:00')
            @course.meeting_days = ['M','T','W']
            @course.term_id = 1
            @course.save
        
        @schedule = Schedule.new
            @schedule.name = "Test 1"
            @schedule.user_id = @user.id
            @schedule.courses.push(@course)
            @schedule.save
            
        @cohort.users.push(@user)
        @user.schedules.push(@schedule)
        @user.save
    end
    
    describe "is_conflict?" do
        it "should return the course if there is a conflict" do
            #print(DateTime.new(2001,2,3,5,5,6,'+03:00'))
            conflict = Scheduler_2.is_conflict?('M',DateTime.new(2001,2,3,12,5,6,'-05:00'),@user.schedules[0])
            expect(conflict).to eql(@course)
        end
        
        it "should return false if there is not a conflict" do
            conflict = Scheduler_2.is_conflict?('M',DateTime.new(2001,2,3,14,5,6,'-05:00'),@user.schedules[0])
            expect(conflict).to eql(false)
        end
        
        it "should return false if the course is not held on that day" do
            conflict = Scheduler_2.is_conflict?('F',DateTime.new(2001,2,3,12,5,6,'-05:00'),@user.schedules[0])
            expect(conflict).to eql(false)
        end
    end
    
    describe "generate_time_slots" do
        before do
            Scheduler_2.Generate_time_slots(@cohort)
        end
        it "should generate time_slot db entries" do
            expect(@cohort.time_slots.length).to eql(140)
        end
        
        it "should generate a conflict db entry when a conflict is found" do
            expect(@cohort.time_slots[12].conflicts.length).to eql(1)
        end
        describe "Conflicts generated" do
            it "Should contain the user that had the conflict" do
                expect(@cohort.time_slots[12].conflicts[0].user).to eql(@user) 
            end
            
            it "Should contain the course that is in conflict" do
                expect(@cohort.time_slots[12].conflicts[0].course).to eql(@course)
            end
            it "If there is a conflict it should set was_conflict to true" do
                expect(@cohort.time_slots[12].was_conflict).to eql(true)
            end
        end
    end
end