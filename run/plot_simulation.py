from matplotlib import pyplot as plt, patches
import numpy as np

plt.rcParams["figure.figsize"] = [8.00,5.0]
plt.rcParams["figure.autolayout"] = True

#beginning layout

data1 = np.loadtxt('run/beginning_layout.10') #read the beginning layout data into a list

#The position of the footprint1
xf1 = data1[0][0]
yf1 = data1[0][1]

#The width and lenth of the footprint1
widthf1 = data1[0][2]
lengthf1 = data1[0][3]

#
offset = widthf1*1.4
x_min = xf1 - widthf1*0.5
y_min = yf1 - lengthf1*0.5
x_max = xf1 + widthf1*1.5 + offset
y_max = yf1 + lengthf1*0.1 + offset

#Now some plotting
fig, ax1 = plt.subplots()

#Set limits for the axes
ax1.set_ylim(y_min,y_max)
ax1.set_xlim(x_min,x_max)

#Hide the axes
ax1.get_xaxis().set_visible(False)
ax1.get_yaxis().set_visible(False)

#add footprint rectangle to the plot
ax1.add_patch(patches.Rectangle((xf1, yf1), widthf1, lengthf1, edgecolor='rebeccapurple',facecolor='none', linewidth=1, linestyle = '--'))

print(' ')
# add the rectangles of the beginning layout
for i in range(1,len(data1)):
    
    #The position of the rectangle
    x = data1[i][0]
    y = data1[i][1]

    #The width and lenth of the rectangle
    width = data1[i][2]
    length = data1[i][3]

    #add rectangle to the plot
    ax1.add_patch(patches.Rectangle((x, y), width, length, edgecolor='rebeccapurple',facecolor = 'rebeccapurple', alpha = 0.5, linewidth=2))



data2 = np.loadtxt('run/end_layout.20') #read the end layout data into a list


#The position of the footprint2
xf2 = data2[0][0]
yf2 = data2[0][1]

#The width and lenth of the footprint2
widthf2 = data2[0][2]
lengthf2 = data2[0][3]


#add footprint rectangle to the plot
ax1.add_patch(patches.Rectangle((xf2 + offset, yf2), widthf2, lengthf2, edgecolor='royalblue',facecolor='none', linewidth=1, linestyle = '--'))

print(' ')
for i in range(1,len(data2)):

    #The position of the rectangle
    x = data2[i][0]
    y = data2[i][1]

    #The width and lenth of the rectangle
    width = data2[i][2]
    length = data2[i][3]

    #add rectangle to the plot
    ax1.add_patch(patches.Rectangle((x + offset, y), width, length, edgecolor='royalblue',facecolor = 'royalblue', alpha = 0.8 , linewidth=2))

#add explanations to plot
text1 = f'Beginning Layout \n {widthf1*lengthf1:.2f} m^2'
ax1.text(xf1, yf1 + lengthf1*1.1, text1)

text3 = f'Layout In The End \n {widthf2*lengthf2:.2f} m^2'
ax1.text(xf2 + offset, yf2 + lengthf2*1.1, text3)

plt.show()

#read the data for simulating the SA function
data3 = np.loadtxt('run/SA.30')

#parse x and y data
x = data3[:,0]
y = data3[:,1]


plt.xlim(min(x),max(x))
plt.ylim(min(y), max(y))
plt.title('Area as a function of the parameter c')
plt.xlabel('constant parameter c')
plt.ylabel('Area of the footprint')
plt.plot(x,y, color = 'rebeccapurple')
plt.grid(visible=True)
plt.show()