import time
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import datetime
import os

class Parsing:
    def __init__(self, directory_name):
        initial_directory = "/Users/selbor/SCIPP/LogFiles_Testing/"
        self.directory_name = directory_name
        self.full_directory_name = initial_directory + directory_name
    def cycle_through_files(self):
        sorted_dir = sorted(os.listdir(self.full_directory_name))
        n_files = len(sorted_dir)
        count = 0
        my_list = []
        while count < len(sorted_dir):
            file = sorted_dir[count]
            with open(os.path.join(self.full_directory_name, file), 'r') as f:
                contents = f.readlines()
                first_line = contents[0]
                if self.directory_name == "Rucio":
                    try:
                        last_line = contents[len(contents)-1] 
                        Start_Time = first_line[7:26]
                        End_Time = last_line[7:26]
                        start_time_dt = datetime.datetime(int(Start_Time[0:4]), int(Start_Time[5:7]), int(Start_Time[8:10]), int(Start_Time[11:13]), int(Start_Time[14:16]), int(Start_Time[17:19]))
                        end_time_dt = datetime.datetime(int(End_Time[0:4]), int(End_Time[5:7]), int(End_Time[8:10]), int(End_Time[11:13]), int(End_Time[14:16]), int(End_Time[17:19]))
                        my_list.append((end_time_dt - start_time_dt).total_seconds())
                    except ValueError:
                        last_line = contents[len(contents)-10]
                        Start_Time = first_line[7:26]
                        End_Time = last_line[7:26]
                        start_time_dt = datetime.datetime(int(Start_Time[0:4]), int(Start_Time[5:7]), int(Start_Time[8:10]), int(Start_Time[11:13]), int(Start_Time[14:16]), int(Start_Time[17:19]))
                        end_time_dt = datetime.datetime(int(End_Time[0:4]), int(End_Time[5:7]), int(End_Time[8:10]), int(End_Time[11:13]), int(End_Time[14:16]), int(End_Time[17:19]))
                        my_list.append((end_time_dt - start_time_dt).total_seconds())
                    except:
                        print("File {} is giving an error.".format(file))
                elif self.directory_name == "EVNT" or self.directory_name == "TRUTH3" or self.directory_name == "TRUTH3_centos7":
                    last_line = contents[len(contents)-2]
                    Start_Time = first_line[22:41]
                    End_Time = last_line[37:56]
                    start_time_dt = datetime.datetime(int(Start_Time[0:4]), int(Start_Time[5:7]), int(Start_Time[8:10]), int(Start_Time[11:13]), int(Start_Time[14:16]), int(Start_Time[17:19]))
                    end_time_dt = datetime.datetime(int(End_Time[0:4]), int(End_Time[5:7]), int(End_Time[8:10]), int(End_Time[11:13]), int(End_Time[14:16]), int(End_Time[17:19]))
                    new_name = "{}.{}.{}.T{}.{}.{}.log".format(Start_Time[0:4], Start_Time[5:7], Start_Time[8:10], Start_Time[11:13], Start_Time[14:16], Start_Time[17:19])
                    os.rename(os.path.join(self.full_directory_name, file), os.path.join(self.full_directory_name, new_name))
                    my_list.append((end_time_dt - start_time_dt).total_seconds())
                elif self.directory_name == "TRUTH3_centos7_interactive":
                    last_line = contents[len(contents)-1]
                    Start_Time = file
                    End_Time = last_line[21:40]
                    start_time_dt = datetime.datetime(int(Start_Time[0:4]), int(Start_Time[5:7]), int(Start_Time[8:10]), int(Start_Time[11:13]), int(Start_Time[14:16]), int(Start_Time[17:19]))
                    end_time_dt = datetime.datetime(int(End_Time[0:4]), int(End_Time[5:7]), int(End_Time[8:10]), int(End_Time[11:13]), int(End_Time[14:16]), int(End_Time[17:19]))
                    my_list.append((end_time_dt - start_time_dt).total_seconds())
            count += 1
        file_1 = sorted(os.listdir(self.full_directory_name))[0]
        file_n = sorted(os.listdir(self.full_directory_name))[n_files-1]
        first_measurement = datetime.datetime(int(file_1[0:4]), int(file_1[5:7]), int(file_1[8:10]), int(file_1[12:13]), int(file_1[15:16]), int(file_1[18:19]))
        final_measurement = datetime.datetime(int(file_n[0:4]), int(file_n[5:7]), int(file_n[8:10]), int(file_n[12:13]), int(file_n[15:16]), int(file_n[18:19]))
        return my_list, first_measurement, final_measurement
class plotting(Parsing):
    def __init__(self, directory_name, my_list, first_measurement, final_measurement):
        super().__init__(directory_name)
        self.my_list = my_list
        self.first_measurement = first_measurement
        self.final_measurement = final_measurement
    def make_the_plot(self):
        if self.directory_name == "Rucio":
            horizontal_axis = pd.date_range(start = self.first_measurement, end = self.final_measurement, freq = '6h')
            fig, ax = plt.subplots()
            date_fomatting = mdates.DateFormatter(fmt='%Y-%m-%d %H:%M')
            ax.plot(horizontal_axis, self.my_list)
            ax.scatter(horizontal_axis, self.my_list)
            ax.grid()
            fig.set_size_inches(20,9)
            ax.xaxis.set_major_formatter(date_fomatting)
            fig.autofmt_xdate()
            plt.title("{} Downloads".format(self.directory_name), size = 15)
            plt.xlabel("Start Time", size = 15)
            plt.ylabel("Time Taken \n Measured in Seconds", size = 15)
            plt.show()
        else:
            freq = len(self.my_list)
            horizontal_axis = pd.date_range(start = self.first_measurement, end = self.final_measurement, periods = freq)
            fig, ax = plt.subplots()
            date_fomatting = mdates.DateFormatter(fmt='%Y-%m-%d %H:%M')
            ax.plot(horizontal_axis, self.my_list)
            ax.scatter(horizontal_axis, self.my_list)
            ax.grid()
            fig.set_size_inches(20,9)
            ax.xaxis.set_major_formatter(date_fomatting)
            fig.autofmt_xdate()
            plt.title("{} Downloads".format(self.directory_name), size = 15)
            plt.xlabel("Start Time", size = 15)
            plt.ylabel("Time Taken \n Measured in Seconds", size = 15)
            plt.show()
