import asyncio
import json
import logging
from threading import Thread
import uvloop

import websockets
from dadou_utils.com.input_messages_list import InputMessagesList

from dadou_utils.singleton import SingletonMeta


class WsServer(Thread):

    async def handler(websocket):
        async for message in websocket:
            InputMessagesList().messages.append(json.loads(message))
            logging.info(message)
            print(message)
            await websocket.send("I recieved : "+message)

    @staticmethod
    async def main():
        async with websockets.serve(WsServer.handler, "0.0.0.0", 4421):
            await asyncio.Future()  # run forever

    def run(self):
        uvloop.install()
        asyncio.run(WsServer.main())
