"""The title screen, as the game draws it after power-on."""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from _game import Machine  # noqa: E402

GROUP = 'screens'


def build(ctx):
    m = Machine(ctx)
    for _ in range(200):
        m.frame()
    title = m.screen()
    ctx.poster(title, 'title')                  # gen/screens_title.png: the hub's thumbnail
    return [{
        'name': 'title-screen', 'type': 'image', 'title': 'Title screen',
        'width': 160, 'height': 144, 'pixels': ctx.pixels(title), 'scale': 2,
        'doc': ['The title screen as the game draws it after power-on: the Dragon Slayer logo, GAME START '
                'and the credits of Nihon Falcom and Epoch. There is no demo: the screen waits for a button.'],
    }]
