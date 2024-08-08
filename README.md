# Weather App

Es una simple app que muestra la actualización del clima por coordenadas. La misma utiliza una API global llamada "OpenWeatherMap", este es un desafío propuesto por el equipo de Wonk.

## Estructura del Proyecto

La estructura del proyecto sigue un enfoque modular y organizado, dividido en varias capas para mantener una separación clara de responsabilidades:

- **Servicios (Services)**:
  - Encargados de manejar la comunicación HTTP y las preferencias compartidas (almacenamiento local).
  - Ejemplos: `GeoLocatorService`, `PreferencesServices`.

- **Fuentes de Datos (Data Sources)**:
  - Se encargan de la obtención de datos remotos (API) y locales. Aquí es donde se realiza la interacción directa con las fuentes de datos.
  - Ejemplos: `WeatherApiDataSource`, `LocalStorageDataSource`.

- **Repositorios (Repositories)**:
  - Actúan como una capa intermedia entre las fuentes de datos y los casos de uso, proporcionando una abstracción para obtener y manejar los datos.
  - Ejemplos: `WeatherRepository`.

- **Casos de Uso (Use Cases)**:
  - Encapsulan una funcionalidad de negocio específica y actúan como una capa de aplicación. Se encargan de la lógica de negocio y la coordinación entre los repositorios y la UI.
  - Ejemplos: `FetchWeatherUseCase`.

- **Gestión del Estado con Bloc**:
  - Bloc gestiona el estado de la UI y maneja la lógica de negocio a través de eventos y estados. Facilita la separación entre la lógica de negocio y la presentación.
  - Ejemplos: `WeatherBloc`, `WeatherEvent`, `WeatherState`.

- **Inyección de Dependencias con GetIt**:
  - GetIt facilita la inyección de dependencias, asegurando que cada parte del código reciba sus dependencias necesarias de manera eficiente y desacoplada.
  - Ejemplos: Configuración de `GetIt` para instanciar y proporcionar servicios y repositorios a lo largo de la aplicación.

Cada una de estas capas está diseñada para mantener una arquitectura limpia y modular, facilitando el mantenimiento y la escalabilidad del proyecto.

## Características

- **Visualización del Clima**: Muestra la temperatura actual y el estado del tiempo (e.g., soleado, nublado) en la ubicación del usuario.
- **Actualización Manual**: Permite al usuario actualizar la ubicación actual y obtener datos de clima más recientes con un botón de recarga.
- **Interfaz de Usuario**: Utiliza animaciones de carga y una interfaz amigable para proporcionar una experiencia fluida.
- **Geolocalización en Tiempo Real**: Utiliza un sistema de streaming para actualizar automáticamente la ubicación del usuario cuando cambia de ubicación. Esto permite una actualización continua del clima basado en la ubicación actual.


## Tecnologías Utilizadas

- **Flutter**: Framework para desarrollar aplicaciones móviles multiplataforma.
- **Dart**: Lenguaje de programación utilizado por Flutter.
- **Geolocator**: Paquete para obtener la ubicación actual del usuario.
- **Shared Preferences**: Paquete para almacenar datos locales.
- **Bloc**: Patrón de gestión de estado utilizado para manejar el estado de la aplicación.
- **Loading Animation Widget**: Paquete para mostrar animaciones de carga.

## Instalación

1. **Clonar el Repositorio**
   ```bash
   git clone https://github.com/tu-usuario/weather-app.git

2. **Instalar Dependencias y ejecutar**
   ```bash
   git clone https://github.com/tu-usuario/weather-app.git

3. **Navegar al Directorio del Proyecto**
   ```bash
   Asegúrate de tener Flutter instalado en tu sistema. Luego, ejecuta:
   flutter pub get
   flutter run

Aquí tienes el README.md con la estructura y detalles que proporcionaste:

markdown
# Weather App

Es una simple app que muestra la actualización del clima por coordenadas. La misma utiliza una API global llamada "OpenWeatherMap", este es un desafío propuesto por el equipo de Wonk.

## Estructura del Proyecto

La estructura del proyecto sigue un enfoque modular y organizado, dividido en varias capas para mantener una separación clara de responsabilidades:

- **Servicios (Services)**:
  - Encargados de manejar la comunicación HTTP y las preferencias compartidas (almacenamiento local).
  - Ejemplos: `GeoLocatorService`, `PreferencesServices`.

- **Fuentes de Datos (Data Sources)**:
  - Se encargan de la obtención de datos remotos (API) y locales. Aquí es donde se realiza la interacción directa con las fuentes de datos.
  - Ejemplos: `WeatherApiDataSource`, `LocalStorageDataSource`.

- **Repositorios (Repositories)**:
  - Actúan como una capa intermedia entre las fuentes de datos y los casos de uso, proporcionando una abstracción para obtener y manejar los datos.
  - Ejemplos: `WeatherRepository`.

- **Casos de Uso (Use Cases)**:
  - Encapsulan una funcionalidad de negocio específica y actúan como una capa de aplicación. Se encargan de la lógica de negocio y la coordinación entre los repositorios y la UI.
  - Ejemplos: `FetchWeatherUseCase`.

- **Gestión del Estado con Bloc**:
  - Bloc gestiona el estado de la UI y maneja la lógica de negocio a través de eventos y estados. Facilita la separación entre la lógica de negocio y la presentación.
  - Ejemplos: `WeatherBloc`, `WeatherEvent`, `WeatherState`.

- **Inyección de Dependencias con GetIt**:
  - GetIt facilita la inyección de dependencias, asegurando que cada parte del código reciba sus dependencias necesarias de manera eficiente y desacoplada.
  - Ejemplos: Configuración de `GetIt` para instanciar y proporcionar servicios y repositorios a lo largo de la aplicación.

Cada una de estas capas está diseñada para mantener una arquitectura limpia y modular, facilitando el mantenimiento y la escalabilidad del proyecto.

## Características

- **Visualización del Clima**: Muestra la temperatura actual y el estado del tiempo (e.g., soleado, nublado) en la ubicación del usuario.
- **Actualización Manual**: Permite al usuario actualizar la ubicación actual y obtener datos de clima más recientes con un botón de recarga.
- **Interfaz de Usuario**: Utiliza animaciones de carga y una interfaz amigable para proporcionar una experiencia fluida.

## Tecnologías Utilizadas

- **Flutter**: Framework para desarrollar aplicaciones móviles multiplataforma.
- **Dart**: Lenguaje de programación utilizado por Flutter.
- **Geolocator**: Paquete para obtener la ubicación actual del usuario.
- **Shared Preferences**: Paquete para almacenar datos locales.
- **Bloc**: Patrón de gestión de estado utilizado para manejar el estado de la aplicación.
- **Loading Animation Widget**: Paquete para mostrar animaciones de carga.

## Instalación

1. **Clonar el Repositorio**

```bash
git clone https://github.com/tu-usuario/weather-app.git
Navegar al Directorio del Proyecto


cd weather-app
Instalar Dependencias

Asegúrate de tener Flutter instalado en tu sistema. Luego, ejecuta:

flutter pub get
Ejecutar la Aplicación

Conecta un dispositivo físico o inicia un emulador y ejecuta:

flutter run

## Uso:
Pantalla Principal: Al abrir la aplicación, se muestra la temperatura actual y el estado del clima en la ubicación del usuario.
Actualizar Ubicación: Presiona el ícono de recarga para actualizar la ubicación y obtener datos de clima más recientes.
Estructura del Proyecto
lib/: Contiene todo el código fuente de la aplicación.
core/: Servicios y temas globales.
features/: Funcionalidades específicas del clima.
data/: Modelos de datos y servicios.
domain/: Entidades y lógica de negocio.
presentation/: Gestión de la UI y widgets.
main.dart: Punto de entrada de la aplicación.


Contacto
Para cualquier consulta, por favor, contacta a ignaprevi@gmail.com (+443512320184)
