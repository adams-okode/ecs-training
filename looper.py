import math
import time
import psycopg2
import datetime
import pandas as pd
import numpy as np
import math


def kama_looper(self, period, fast_ema, slow_ema, dt1, _max):
    data = dt1.iloc[::-1].values
    # --- get first non nan index
    for i in range(len(data)):
        if np.isnan(data[i]) == False:
            first_non_nan = i
            break

    # --- get last non nan index
    for i in reversed(range(len(data))):
        if np.isnan(data[i]) == False:
            last_non_nan = i
            break
    # print

    # --- define variables
    data_length = len(data)
    # --- define arrays
    # change vs data point `period` in past
    change = np.zeros(len(data))
    # change since last data point
    prev_cur = np.zeros(len(data))
    # sum of last `period` prev_cur values
    volatility = np.zeros(len(data))
    # efficiency ratio
    er = np.zeros(len(data))
    # smoothing constant
    sc = np.zeros(len(data))
    # kama
    kama = np.zeros(len(data))

    tracker = 0

    # --- calculate efficiency ratio
    for i in range(0, data_length):
        tracker += 1
        if tracker > _max:
            break
        if i <= first_non_nan or i > last_non_nan:
            prev_cur[i] = np.nan
            change[i] = np.nan
            volatility[i] = np.nan
            er[i] = np.nan
            sc[i] = np.nan
            kama[i] = np.nan

        elif first_non_nan + period - 1 > i > first_non_nan:
            prev_cur[i] = math.sqrt((data[i] - data[i - 1]) ** 2)
            change[i] = np.nan
            volatility[i] = np.nan
            er[i] = np.nan
            sc[i] = np.nan
            kama[i] = np.nan

        elif i == first_non_nan + period - 1:
            prev_cur[i] = math.sqrt((data[i] - data[i - 1]) ** 2)
            change[i] = math.sqrt((data[i - 1] - data[i - period]) ** 2)
            volatility[i] = np.nan
            er[i] = np.nan
            sc[i] = np.nan
            # --- first kama value is the sma
            kama[i] = sum(data[i: i + period]) / period

        elif i > first_non_nan + period - 1:
            prev_cur[i] = math.sqrt((data[i] - data[i - 1]) ** 2)
            change[i] = math.sqrt((data[i] - data[i - period]) ** 2)
            volatility[i] = sum(prev_cur[i - period + 1: i + 1])
            er[i] = change[i] / volatility[i]
            sc[i] = (
                er[i] * ((2 / (fast_ema + 1)) - (2 / (slow_ema + 1)))
                + (2 / (slow_ema + 1))
            ) ** 2
            kama[i] = kama[i - 1] + sc[i] * (data[i] - kama[i - 1])
    return kama


def checkScenariosTrue(self):
    caseOutput = []
    scenarios = self.scenarios
    for scenario in scenarios:
        smas = self.looper(self.dt, scenario['case'], self.max)
        scenario['data'] = smas
        logger.info(smas)
        # logger.info(smas)
        scenario['output'] = self.checkConsecutiveBuy(smas)
        caseOutput.append(scenario['output'])
    self.checkConsecutiveBuy(smas)
    self.scenarios = scenarios

    # timex = datetime.datetime.now()

    # # logger.info(timex)
    # logger.info(f"////////////////////////////////////////////////////////////")
    # # logger.info("////////////////////////////////////////////////////////////")
    if list(caseOutput)[1:] == list(caseOutput)[:-1] and caseOutput[0] == True:
        return True

    return False


def checkConsecutiveBuy(self, data, direction='forward'):
    length = len(data)
    check = False
    if direction == 'forward':
        for i in range(1, length, 1):
            check = True
            if data[i-1] > data[i]:
                check = False
                break
    elif direction == 'backward':
        for i in range(1, length, 1):
            check = True
            if data[i-1] < data[i]:
                check = False
                break
    return check


def checKamaDirectionTrue(self):
    kamaz = self.kamaz
    for scenario in kamaz:
        kama = self.kama_looper(10, 2, 30, self.dt, 5)
        kamaDirection = self.checkConsecutiveBuy(kama)
        scenario['data'] = kama
        # logger.info(smas)
        scenario['output'] = self.checkConsecutiveBuy(kamaDirection)
    self.kamaz = kamaz
