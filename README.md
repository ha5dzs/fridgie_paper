# An early warning system for air conditioners using simple machine learning to minimise maintenance costs and environmental impact

Zoltan Derzsi
zd8 [at] nyu [?] edu

New York University Abu Dhabi, United Arab Emirates; Heaviside Instiitute

## Abstract

In hot climate countries, a high proportion of energy produced is used up for air conditioning. Since homeowners cannot always recognize when their air conditioners are losing efficiency, several faults remain undetected until catastrophic failure occurs. Here, a low-cost n early warning system is presented that only measures the temperatures at key locations of the refrigeration circuit along with the utilization rate of the system. A neural network is trained to recognize early signs of failure, and the trained model is small enough to fit in a microcontroller. Such a system can help not only with preventing excessive energy consumption prior to complete failure, but can also reduce the amount of refrigerant leaked into the atmosphere.

### Keywords

air conditioning, machine learning, mini split, failure detection, diagnostics, early warning

## Intorduction

The ductless split air conditioner is a popular choice for residential applications. In a hot desert climate country such as the United Arab Emirates (UAE), it was reported in nationwide media that as much as 70\% of the energy produced is used for air conditioning[^1]. Since the air conditioner is one of the highest power domestic appliances in a typical UAE home, maintaining it becomes very important in order to keep their coefficient-of-performance (COP) values as specified by the manufacturer. In the home, the responsibility of maintenance falls to the owner, but in the vast majority of cases a technician is only called when the air conditioner stops working completely[^2]. By this point, catastrophic damage has almost certainly occurred, and the only way to repair is through replacing major components. Perhaps, since air conditioners are sold in electronics stores and hypermarkets, the owners do not consider them as mechanical devices that require regular maintenance, but as an electronic device that has a fixed albeit short lifespan.

As the most common cause for a split air conditioner to fail is through refrigerant leak[^3][^4][^5], there are telltale signs that can be used for early diagnosis. Such signs are lower cooling capacity and increased utilization of the compressor, but these are usually ignored by the owner because these cannot easily be measured without tools. At the very least, an increased electricity bill should be an indicator for problems, but often the owner attributes it to climate change and irresponsible use of air conditioning, rather than a sign of oncoming failure.

Another, less common fault is due to poor maintenance: a poor air flow through the coils, either due to clogged filters or improper installation, will also degrade the COP. In extreme cases this could cause the air conditioner to freeze up, and the liquid refrigerant may reach the compressor inflicting damage on it. Additionally, especially in sandy-dusty desert climates, the condenser may become clogged or its fan could slow down due to increased friction. Both these cases would result in decreased COP, as the heat from the home could not be efficiently transferred into the outside environment.

The concept of a fault detection and diagnostic (FDD) system has been around for a while[^6][^2][^7], but for residential applications is rarely used: the legislation does not require it; the manufacturers do not include it because it would increase cost and put them at a disadvantage in competition; and additional components in the refrigeration circuit such as pressure sensors or switches would introduce more points of failure. Instead, FDD systems are most common in commercial air conditioners with much higher reliability requirements.

An FDD system can rely on statistical and/or machine learning models[^8][^9][^10], and they also use environmental sensor data (thermostat setting and user habits, temperature probes, etc.) as well as refrigeration circuit sensor data. There is also a proposal for unifying the FDD system with other systems, such as fire safety and building management systems[^11], which would fit with several smart home and smart building initiatives.

Compared with an FDD system, the Early Warning System (EWS) is only concerned with the air conditioner's refrigeration cycle, in a similar way to how a technician would diagnose it during a callout. When a technician inspects such a system, the key parameters are calculated based on the measured refrigerant pressures and temperatures. While taking the measurements at the high-pressure line would be useful to calculate the subcooling values, which would help with estimating the actual COP of the system under test, the split air conditioners often do not have a high pressure service port due to cost cutting measures. As some air conditioners can be interfaced with home automation systems, the environmental condition monitoring functionality of an FDD system is already implemented: the user would get a notification if the air conditioner "struggles" or fails to maintain temperature for one reason or another.

In this paper, a simple and low cost independent early warning system is introduced that is aimed for residential applications, and it can be implemented on existing split type air conditioners with minimal modifications.

## Methods

### Data processing: traditional statistics and machine learning

## Implementation and results

### Data generation and the machine learning model

## Discussion

## Funding and acknowledgements

###### A note on why things are the way things are


[^1]: Bardsley, D.: [Working from Home Could Create Surge in Gulf’s AC Bills and Emissions](https://www.thenationalnews.com/uae/environment/working-from-home-could-create-surge-in-gulf-s-ac-bills-and-emissions-1.1077001). The National, Accessed 23/10/2023

[^2]: Breuker, M. S., & Braun, J. E. (1998). Common faults and their impacts for rooftop air conditioners. Science and Technology for the Built Environment, 4(3), 303. [https://doi.org/10.1080/10789669.1998.10391406](https://doi.org/10.1080/10789669.1998.10391406)

[^3]: Chandra, A. R., & Arora, R. C. (2012). Refrigeration and air conditioning. PHI Learning Pvt. Ltd. [ISBN: 9788120339156](https://isbnsearch.org/isbn/9788120339156)

[^4]: Kim, W., & Braun, J. E. (2012). Evaluation of the impacts of refrigerant charge on air conditioner and heat pump performance. International journal of refrigeration, 35(7), 1805-1814. [https://doi.org/10.1016/j.ijrefrig.2012.06.007](https://doi.org/10.1016/j.ijrefrig.2012.06.007)

[^5]: Kim, D. H., Park, H. S., & Kim, M. S. (2014). The effect of the refrigerant charge amount on single and cascade cycle heat pump systems. International journal of refrigeration, 40, 254-268. [https://doi.org/10.1016/j.ijrefrig.2013.10.002](https://doi.org/10.1016/j.ijrefrig.2013.10.002)

[^6]: [Stouppe, D. E., & Lau, Y. S. (1989). Air conditioning and refrigeration equipment failures. National Engineer, 93(9), 14-17.](https://scholar.google.com/scholar?hl=hu&as_sdt=0%2C5&q=touppe%2C+D.%2C+Lau%2C+Y.%3A+Air+conditioning+and+refrigeration+equipment+failures.+National+Engineer+93%289%29%2C+14%E2%80%9317+%281989%29&btnG=)

[^7]: Rogers, A. P., Guo, F., & Rasmussen, B. P. (2019). A review of fault detection and diagnosis methods for residential air conditioning systems. Building and Environment, 161, 106236. [https://doi.org/10.1016/j.buildenv.2019.106236]https://doi.org/10.1016/j.buildenv.2019.106236)

[^8]: Hu, M., Chen, H., Shen, L., Li, G., Guo, Y., Li, H., ... & Hu, W. (2018). A machine learning bayesian network for refrigerant charge faults of variable refrigerant flow air conditioning system. Energy and Buildings, 158, 668-676. [https://doi.org/10.1016/j.enbuild.2017.10.012](https://doi.org/10.1016/j.enbuild.2017.10.012)

[^9]: Lei, Q., Zhang, C., Shi, J., & Chen, J. (2022). Machine learning based refrigerant leak diagnosis for a vehicle heat pump system. Applied Thermal Engineering, 215, 118524. [https://doi.org/10.1016/j.applthermaleng.2022.118524](https://doi.org/10.1016/j.applthermaleng.2022.118524)

[^10]: Godahewa, R., Deng, C., Prouzeau, A., & Bergmeir, C. (2022). A Generative Deep Learning Framework Across Time Series to Optimize the Energy Consumption of Air Conditioning Systems. IEEE Access, 10, 6842-6855. [https://doi.org/10.1109/ACCESS.2022.3142174](https://doi.org/10.1109/ACCESS.2022.3142174)

[^11]: Awawdeh, M., Bashir, A., Faisal, T., Alhammadi, K., Almansori, M., & Almazrouei, S. (2019, March). Embedded ventilation air conditioning system for protection purposes with IoT control. In 2019 Advances in Science and Engineering Technology International Conferences (ASET) (pp. 1-6). IEEE. [https://doi.org/10.1109/ICASET.2019.8714295](https://doi.org/10.1109/ICASET.2019.8714295)

[^12]: []()

[^13]: []()

[^14]: []()