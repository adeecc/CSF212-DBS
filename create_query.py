import csv

tablename = 'book'

with open(f'{tablename}.csv', newline='') as infile:
    datareader = csv.reader(infile)
    with open('insert_query.sql', 'a+') as outfile:
        for row in datareader:
            values = ", ".join(cell for cell in row) 
            query = f"INSERT INTO {tablename} VALUES ({values});\n"
            outfile.write(query)

        outfile.write("\n")