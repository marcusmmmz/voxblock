# VoxBlock

VoxBlock is a Minetest mod that visualizes Bitcoin blockchain data in a voxel world. It creates a real-time representation of the Bitcoin blockchain height using blocks in the game, bridging the worlds of blockchain and gaming in an educational and interactive way.

## A live demo of this mod is being live streamed: https://www.twitch.tv/tulkasbtc

## Current Features

- Displays the current Bitcoin blockchain height in-game
- Automatically updates every 60 seconds
- Allows manual updates via command
- Customizable block position
- Simplified representation of Bitcoin network statistics

## Installation

1. Clone this repository or download the ZIP file.
2. Open the .minetest folder. To find it, go to the About tab when you open minetest, and click Open User Data Directory
3. Place the `voxblock` folder in your Minetest mods directory. (or create a mods folder if it doesn't exist)
4. Create a world, click the select mods button and enable the mod voxblock.
5. Open your `minetest.conf` file.
6. Add a line at the end: `secure.http_mods = voxblock`. (This makes the mod allow http requests, so it can use blockchain data)
7. Save the file and open your world.

## Usage

1. After installing and enabling the mod, join your Minetest world.
2. Set the position for the block height display:
   - Move your player to the desired location
   - Run the command: `/set_block_height_coords` (use T to open the chat for running commands)
3. The block height will now appear and update automatically every 60 seconds.
4. To force an update, use the command: `/update_block_height`

## Commands

- `/set_block_height_coords`: Sets the location for the block height display using your current player position.
- `/update_block_height`: Manually updates the block height display.

## Educational Value

VoxBlock is designed to make blockchain concepts more accessible and engaging, especially for younger audiences and families. It visualizes complex ideas like:

- Blockchain height and growth
- Real-time updates of the Bitcoin network
- The relationship between blocks in a blockchain

Future updates may include more educational features and mini-games to explore other blockchain concepts.

## Acknowledgements

- Bitcoin blockchain data is fetched from [Mempool Space](https://mempool.space/)
- Built using the [Minetest engine](https://www.minetest.net/)
- Inspired by the need for family-friendly Bitcoin blockchain education
