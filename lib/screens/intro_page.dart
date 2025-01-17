import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 255, 216, 148),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    Color(0xFFFFA07A),
                    Color(0xFFFF6347),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ).createShader(bounds),
                child: Text(
                  'TaskLy',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'PassionOne',
                        fontSize: 45,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/toDoList.png',
                      width: 300,
                      height: 300,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Welcome to TaskLy',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: 'Montserrat',
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Text(
                        'Taskly makes organizing and completing your to-dos straightforward and easy.',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black87,
                            fontSize: 16,
                            fontFamily: 'Ubuntu'),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 15),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFFFFA07A),
                                Color(0xFFFF6347),
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Get Started',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Ubuntu',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(Icons.arrow_forward,
                                  size: 24, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
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
