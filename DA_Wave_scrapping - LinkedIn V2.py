#!/usr/bin/env python
# coding: utf-8

# In[2]:


get_ipython().system('pip install selenium')


# In[3]:


import time
import numpy as np
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By

from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.common.exceptions import NoSuchElementException


# In[8]:


#Open the driver

url="https://www.linkedin.com/jobs/search?keywords=Data%20Analyst&location=Val-de-Marne%2C%20%C3%8Ele-de-France%2C%20France&geoId=104122256&trk=public_jobs_jobs-search-bar_search-submit&position=1&pageNum=0"

driver = webdriver.Chrome()
driver.get(url)


# In[9]:


url_list=[]

for _ in range(6): #number of scrolls before to click on see more button
    driver.execute_script("window.scrollTo(0,document.body.scrollHeight)")
    time.sleep(2)
    url_list.append(driver.current_url)
driver.execute_script("window.scrollTo(0,document.body.scrollHeight)")

for j in range(30): #number of clicks to make
    driver.find_element(By.XPATH,'//*[@id="main-content"]/section[2]/button').click()
    time.sleep(2)
    driver.execute_script("window.scrollTo(0,document.body.scrollHeight)")
    url_list.append(driver.current_url)
    time.sleep(2)


# In[ ]:


ads=[]
for num in range(1,407):

# right window section
    try:
        detailed=driver.find_element(By.XPATH,f'//*[@id="main-content"]/section[2]/ul/li[{num}]/div')
    except:
        detailed=driver.find_element(By.XPATH,f'//*[@id="main-content"]/section[2]/ul/li[{num}]/a')
    detailed.click()
    time.sleep(3)

    job_title = detailed.find_element(By.CLASS_NAME,'base-search-card__title').text.strip()
    job_company = detailed.find_element(By.CLASS_NAME,'base-search-card__subtitle').text.strip()
    job_location = detailed.find_element(By.CLASS_NAME,'job-search-card__location').text.strip()
    try:
        date_element = detailed.find_element(By.CLASS_NAME,'job-search-card__listdate')
    except:
        date_element = detailed.find_element(By.CLASS_NAME,'job-search-card__listdate--new')
    posted_date = date_element.get_attribute('datetime')
    try:
        job_salary = job.find_element(By.CLASS_NAME,'job-search-card__salary-info').text.strip()
    except:
        job_salary = np.nan
    # try:
    #     candidates = detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/section/div/div[1]/div/h4/div[2]/figure/figcaption').text
    # except:
    #     try:
    #         candidates = detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/section/div/div[1]/div/h4/div[2]/span[2]').text
    #     except:
    #         candidates = detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/section/div/div[2]/div/h4/div[2]/figure/figcaption').text


    try:
        function=detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/div/section[1]/div/ul/li[3]/span').text
    except:
        None
    try:
        hierarchy=detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/div/section[1]/div/ul/li[1]/span').text
    except:
        None
    try:
        type=detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/div/section[1]/div/ul/li[2]/span').text
    except:
        None
    try:
        sector=detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/div/section[1]/div/ul/li[4]/span').text
    except:
        None
    whole_desc=detailed.find_element(By.XPATH,'/html/body/div[1]/div/section/div[2]/div/section[1]/div/div/section/div').text

    
    ad={'job_title': job_title,
        'job_company' : job_company,
        'job_location' : job_location,
        'posted_date' : posted_date,
        'job_salary' : job_salary,
        'function' : function,
        'type': type,
        'hierarchy' : hierarchy,
        'sector':sector,
        'whole_desc':whole_desc}
    ads.append(ad)

ads


# In[28]:


#update the name according to the filters you've used (i.e CDI_remote)
linkedin_onsite_haut_de_seine_others = pd.DataFrame(ads)
linkedin_onsite_haut_de_seine_others


# In[29]:


linkedin_onsite_haut_de_seine_others.to_csv("linkedin_onsite_haut_de_seine_others.csv")


# In[7]:


driver.quit()


# In[ ]:




