Tutorial to compare versions in Git
============
Edited: 11.Oct.2021, by Marcelo Ruaro

List of commands
-----------

### 1. Get the remote path (inside the working version)
```git config --get remote.origin.url```

### 2. Indetify the commit's hash that you want to use as reference in the comparison (inside the working version)
```git log```

* Copy the hash code, ex: 
```5a2510188d17e86a38d7a036e1d9591613045e6e```
### 3. Create a new folder
```mkdir to_delete```

```cd to_delete``` 

### 4. Clone your working version
```git clone <my_remote_path>```


### 5. Checkout to the version that you want to compare
```git checkout -b 5a2510188d17e86a38d7a036e1d9591613045e6e```

### 6. Use a practical comparator, ex: meld to compare between the two folders

```meld main_version/ to_delete/comparision_version```