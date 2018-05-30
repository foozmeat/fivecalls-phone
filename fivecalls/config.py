import platform
import subprocess

from kivy.config import Config

from fivecalls.singleton import Singleton


class KivyConfig(metaclass=Singleton):

    def __init__(self):
        self.scale = 1.0

        Config.set('kivy', 'exit_on_escape', 0)
        Config.set('kivy', 'desktop', 0)

        Config.set('graphics', 'width', 480)
        Config.set('graphics', 'height', 800)
        Config.set('graphics', 'borderless', 1)

        if platform.system() == 'Darwin':
            if 'Retina' in subprocess.getoutput('system_profiler SPDisplaysDataType'):
                self.scale = 2.0

        else:
            Config.set('input', 'pitft', 'mtdev,/dev/input/event2,rotation=270')

        self.padding = 20
        self.width = (480 * self.scale) - self.padding
        self.height = (800 * self.scale) - self.padding
        self.font_size = 15 * self.scale


if __name__ == '__main__':
    kc = KivyConfig()
    print(f"display scale: {kc.scale}")

    kc2 = KivyConfig()

    assert (id(kc) == id(kc2))
