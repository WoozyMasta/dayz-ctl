# DayZ Command Line Launcher

Это экспериментальный лаунчер (обозреватель серверов и средство запуска) [DayZ][] в [Steam][221100] [Proton][] для Linux.

![](extra/dayz-ctl-logo.svg)

На момент реализации этого проекта [Bohemia Interactive][] всё еще не смогла сделать рабочий лаунчер для игры, который мог бы корректно устанавливать модификации и подключатся к игровым серверам. По этой причине появился этот проект.

Основные особенности:

* Обозреватель серверов с информацией о каждом сервере
* Нечеткий поиск в обозревателе серверов на базе [fzf][]
* Автоматическая установка модов (как опция)
* Широкий набор фильтров для поиска серверов (карта, время суток, модификации, количество игроков, от первого лица, пароль и т.п.)
* Дополнительная информация в виде страны расположения (используя geoip базу) и ping для каждого сервера
* Список избранного, история последних 10 игр и создание ярлыков быстрого запуска для подключения к серверам
* Оффлайн режим [DayZCommunityOfflineMode][] с автоматической установкой, обновлением и возможностью выбора модификаций
* Меню конфигурации с параметрами запуска игры, настройками лаунчера, управлением и статистикой по модам
* Предоставляет ссылку с подробной информацией о сервере на [battlemetrics][]

<center>
<div style="text-align:center;width:80%">

![](extra/2.jpg)

| ![](extra/1.jpg) | ![](extra/3.jpg)  | ![](extra/4.jpg)  |
| ---------------- | ----------------- | ----------------- |
| ![](extra/5.jpg) | ![](extra/6.jpg)  | ![](extra/11.jpg) |
| ![](extra/8.jpg) | ![](extra/9.jpg)  | ![](extra/10.jpg) |
| ![](extra/7.jpg) | ![](extra/12.jpg) | ![](extra/13.jpg) |
</div>
</center>

Отдельное спасибо [dayz-linux-cli-launcher][] за идею и [dayzsalauncher][] за API.

## Особенности использования SteamCMD

Имеется два режима работы лаунчера с использованием SteamCMD для управления модами и без него в ручном режиме.

Вы можете комбинировать оба подхода, к примеру подписываться на те модификации которые вам точно нужны будут в будущем переходя по ссылке, а наличие обновлений проверять или принудительно обновлять моды при помощи лаунчера. Также вы можете не подписываться на "сомнительные 50 модов" очередного сервера и с легкостью удалить их одним действием из лаунчера, при этом сохранив все моды на которые имеется подписка.

### Используя SteamCMD

* 🟢 Всё происходит автоматически
* 🟢 Автоматическая проверка наличия обновлений модов прямо сейчас (принудительно)
* 🟡 Не создается подписки на моды, они просто скачиваются
* 🟡 Требует закрытия клиента Steam для загрузки модов
* 🔴 Иногда нужно повторно авторизоваться в Steam

### Не используя SteamCMD

* 🟢 Привычное поведение если вы уже использовали другие решения, к примеру [dayz-linux-cli-launcher][]
* 🟡 Игра сама не запустится после скачивания модов
* 🟡 Steam бывает задерживает проверку обновлений и скачивает их только после перезапуска или подписки/отписки от мода
* 🔴 Подписываться на моды нужно самому руками

## Установка

Для удобства установки имеется небольшой скрипт который сделает всё за вас (по крайней мере попытается сделать)

Выполните это:

```bash
curl -sSfL https://raw.githubusercontent.com/WoozyMasta/dayz-ctl/master/install | bash
```

## Ручная установка

Для работы лаунчера вам необходимо убедится что у вас установлены все зависимости:

* [jq][] - утилита для обработки JSON
* [fzf][] - утилита для нечеткого поиска
* [gum][] - утилита для создания диалогов и стилизации вывода
* `ping` (`iputils-ping`) - узнаем пинг до сервера (где включен ICMP)
* `geoiplookup` (`geoip-bin`) - узнаем страну размещения сервера
* `whois` - запасной вариант для geoiplookup, менее точный и более медленный, но не все записи есть в стандартной БД geoip
* `curl` - утилита для комуникации с различными API по HTTP/S
* `cut, tr, grep, pgrep, pkill, killal, timeout, sed, awk` (`gawk`) - куда же без класических утилит в скриптах
* [Steam][] - онлайн-сервис цифрового распространения компьютерных игр
* [SteamCMD][] - steamcmd Консольный клиент Steam
* [DayZ][221100] - и естественно сама игра

После чего можете склонировать репозиторий:

```bash
git clone git@github.com:WoozyMasta/dayz-ctl.git
# or
git clone https://github.com/WoozyMasta/dayz-ctl.git
# and run
cd dayz-ctl
./dayz-ctl
```

Или скачать сам файл скрипта:

```bash
curl -sSfL -o ~/.local/bin/dayz-ctl \
  https://raw.githubusercontent.com/WoozyMasta/dayz-ctl/master/dayz-ctl
chmod +x ~/.local/bin/dayz-ctl
# and run
dayz-ctl
```

## Прочее

### Steam

Лучше убирать все параметры запуска DayZ в Steam и управлять ими из лаунчера или наоборот. Так как ключи могут дублироваться и это может вызвать путаницу, или в худшем случае обрежет часть ключей, ведь у строки аргументов есть лимит длинны, а на серверах с большим количеством модов используется и так очень длинный параметр запуска.

Т.е. оставьте параметры запуска пустыми, или укажите только нужный вам набор вспомогательных утилит и переменных, к примеру:

```bash
MANGOHUD=1 ENABLE_VKBASALT=1 gamemoderun %command%
```

### Синтаксис поиска

Вы можете ввести несколько условий поиска, разделенных пробелами. например `^namalsk DE !PVE !RP`

| Token     | Match type                 | Description                          |
| --------- | -------------------------- | ------------------------------------ |
| `sbtrkt`  | fuzzy-match                | Items that match `sbtrkt`            |
| `'wild`   | exact-match (quoted)       | Items that include `wild`            |
| `^music`  | prefix-exact-match         | Items that start with `music`        |
| `.mp3$`   | suffix-exact-match         | Items that end with `.mp3`           |
| `!fire`   | inverse-exact-match        | Items that do not include `fire`     |
| `!^music` | inverse-prefix-exact-match | Items that do not start with `music` |
| `!.mp3$`  | inverse-suffix-exact-match | Items that do not end with `.mp3`    |

Термин с одним символом черты действует как оператор ИЛИ

```regexp
PVE | RP
```

## Полезное

* <https://github.com/FeralInteractive/gamemode>
* <https://github.com/flightlessmango/MangoHud>
* <https://github.com/DadSchoorse/vkBasalt>
* <https://github.com/crosire/reshade-shaders>
* <https://github.com/StuckInLimbo/OBS-ReplayBuffer-Setup>
* <https://github.com/matanui159/ReplaySorcery>
* <https://github.com/LunarG/VulkanTools/blob/master/vkconfig/README.md>

```sh
MANGOHUD=1 ENABLE_VKBASALT=1 gamemoderun %command%
```

```sh
MANGOHUD=0 DXVK_HUD=fps DXVK_FRAME_RATE=60 ENABLE_VKBASALT=1 gamemoderun %command%
```

`DXVK_HUD=fps` ... `DXVK_HUD=full`

* `devinfo` — Displays the name of the GPU and the driver version.
* `fps` — Shows the current frame rate.
* `frametimes` — Shows a frame time graph.
* `submissions` — Shows the number of command buffers submitted per frame.
* `drawcalls` — Shows the number of draw calls and render passes per frame.
* `pipelines` — Shows the total number of graphics and compute pipelines.
* `descriptors` — Shows the number of descriptor pools and descriptor sets.
* `memory` — Shows the amount of device memory allocated and used.
* `gpuload` — Shows estimated GPU load. May be inaccurate.
* `version` — Shows DXVK version.
* `api` — Shows the D3D feature level used by the application.
* `cs` — Shows worker thread statistics.
* `compiler` — Shows shader compiler activity
* `samplers` — Shows the current number of sampler pairs used [D3D9 Only]
* `scale=x` — Scales the HUD by a factor of x (e.g. 1.5)

Frame rate limit `DXVK_FRAME_RATE=0`

<!-- Links -->
[DayZ]: https://dayz.com
[Bohemia Interactive]: https://www.bohemia.net/games/dayz
[221100]: https://store.steampowered.com/app/221100
[dayz-linux-cli-launcher]: https://github.com/bastimeyer/dayz-linux-cli-launcher
[dayzsalauncher]: https://dayzsalauncher.com
[battlemetrics]: https://www.battlemetrics.com
[SteamCMD]: https://developer.valvesoftware.com/wiki/SteamCMD
[fzf]: https://github.com/junegunn/fzf
[jq]: https://github.com/stedolan/jq
[gum]: https://github.com/charmbracelet/gum
[DayZCommunityOfflineMode]: https://github.com/Arkensor/DayZCommunityOfflineMode
[Steam]: https://store.steampowered.com/about/
[Proton]: https://github.com/ValveSoftware/Proton

<!-- 
DayZ DayZSA dayzstandalone dayz standalone linux nix proton steam
DayZ launcher Linux
DayZ servers browser linux
-->
