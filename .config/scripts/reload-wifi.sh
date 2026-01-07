#!/bin/bash

# Unloading module
sudo systemctl stop iwd.service
sudo modprobe -r ath11k_pci

# Loading module
sudo modprobe ath11k_pci
sudo systemctl start iwd.service
