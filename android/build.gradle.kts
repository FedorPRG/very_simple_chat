// android/build.gradle.kts

// 1. БЛОК ДЛЯ ЗАГРУЗКИ ПЛАГИНОВ (buildscript) - ЭТОГО У ВАС НЕТ
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        // Обязательный класс для сборки Android
        classpath("com.android.tools.build:gradle:8.1.0")
        // ⭐ ОБЯЗАТЕЛЬНО ДОБАВИТЬ: Класс для плагина Google Services
        classpath("com.google.gms:google-services:4.4.4")
        // Класс для Kotlin (версия должна совпадать с настройками Flutter/других файлов)
        classpath("org.jetbrains.kotlin:kotlin-gradle-plugin:2.0.20")
    }
}

// 2. БЛОК ДЛЯ ВСЕХ ПРОЕКТОВ (allprojects) - У ВАС УЖЕ ЕСТЬ
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// 3. ВАШ СТАРЫЙ КОД ПРО ПУТИ СБОРКИ - МОЖНО ОСТАВИТЬ
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}