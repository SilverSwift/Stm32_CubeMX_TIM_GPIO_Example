import qbs

Project {
    CppApplication {
        id: app
        consoleApplication: true
        name: "cube_test"
        type: "hex"
        files: [
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_cortex.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_tim.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_rcc_ex.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_flash_ex.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_rcc.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_flash.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_i2c_ex.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_dma.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_tim_ex.c",
            path + "/Src/stm32f3xx_it.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pwr_ex.c",
            path + "/Src/stm32f3xx_hal_msp.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pcd_ex.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pwr.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_i2c.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_spi.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_pcd.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_spi_ex.c",
            path + "/Src/system_stm32f3xx.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal.c",
            path + "/Drivers/STM32F3xx_HAL_Driver/Src/stm32f3xx_hal_gpio.c",
            path + "/Src/main.c",
            path + "/startup_stm32f303xc.s",
        ]

        cpp.positionIndependentCode: false
        cpp.enableExceptions: false
        cpp.executableSuffix: ".elf"

        cpp.commonCompilerFlags:[
            "-g",
            "-gdwarf-2",
            "-Wall",
            "-fdata-sections",
            "-ffunction-sections",
            "-MMD",
            "-MP"
        ]

        cpp.driverFlags:[
            "-mcpu=cortex-m4",
            "-mthumb",
            "-Og",
            "-mfpu=fpv4-sp-d16",
            "-mfloat-abi=hard",
            "-Wl,--gc-sections",
            "-Wl,--start-group",
            "-specs=nano.specs",
            "-fno-strict-aliasing",
            "-Wall",
            "-flto",
        ]

        cpp.includePaths:[
            path + "/Inc",
            path + "/Drivers/STM32F3xx_HAL_Driver/Inc",
            path + "/Drivers/STM32F3xx_HAL_Driver/Inc/Legacy",
            path + "/Drivers/CMSIS/Device/ST/STM32F3xx/Include",
            path + "/Drivers/CMSIS/Include",
        ]

        cpp.defines: [
            "STM32F303xC",
            "USE_HAL_DRIVER",
        ]

        cpp.linkerFlags: [
            "-T" + path + "/STM32F303VCTx_FLASH.ld",
            "-lgcc",
            "-lc",
            "-lm",
            "-lnosys",
        ]

        Rule {
            id: hex
            inputs: ["application"]

            Artifact {
                fileTags: ['hex']
                filePath: product.name + '.hex'
            }

            prepare: {
                var args = [
                    "-O",
                    "binary",
                    "-S",
                    input.filePath,
                    output.filePath,
                ];
                //cpp.toolchainInstallPath + "/" + cpp.toolchainPrefix + "objcopy"

                var extractorPath = "/opt/gcc-arm-none-eabi-5_4-2016q3/arm-none-eabi/bin/objcopy";
                var cmd = new Command(extractorPath, args);
                return cmd;
            }
        }

    }

}
