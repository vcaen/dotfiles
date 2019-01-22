#!/bin/bash

function keymapRemap() {
	hidutil property --set '{"UserKeyMapping":[
		{
			"HIDKeyboardModifierMappingSrc":0x700000064,
			"HIDKeyboardModifierMappingDst":0x700000029
		}
	]}'
}

function keymapReset() {
	hidutil property --set '{"UserKeyMapping":[]}'
}
