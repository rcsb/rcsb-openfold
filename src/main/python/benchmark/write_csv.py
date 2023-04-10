def write_csv_file(file, data):
    with open(file, 'a') as the_file:
        the_file.write(','.join(data) + "\n")
            

def create_csv_file(file):
    with open(file, 'w') as csvfile: 
        print("IDs table created")
        csvfile.write("IDs,sequence \n")