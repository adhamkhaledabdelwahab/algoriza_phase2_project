import 'package:flutter/material.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/card_container_widget.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/day_hour_weather_widget.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/sliver_app_bar.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/sun_state_change_time.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/today_temperature_state.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/weather_extra_data.dart';
import 'package:weather_app/src/features/weather/presentation/widgets/weather_page_widgets/week_days_temperatures.dart';

class WeatherBody extends StatelessWidget {
  const WeatherBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            const CustomSliverAppBar(),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 5,
                ),
                child: Column(
                  children: const [
                    CardContainerWidget(
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 15,
                      ),
                      height: 385,
                      child: DayHourWeatherWidget(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardContainerWidget(
                      height: 100,
                      child: TodayTempState(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardContainerWidget(
                      height: 430,
                      child: WeekDaysTemp(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardContainerWidget(
                      height: 150,
                      child: SunTimeChangeState(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CardContainerWidget(
                      height: 160,
                      child: WeatherExtraData(),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
