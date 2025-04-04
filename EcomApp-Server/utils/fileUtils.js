const { promises } = require('dns')
const fs = require('fs')
const path = require('path')

// Extract the file name from the url
const getFileNameFromUrl = (photoUrl) => {
    try {
        const url = new URL(photoUrl)
        const fileName = path.basename(url.pathname)
        return fileName
    } catch(err){
        console.log('Invalid URl: ', err.message)
        return null
    }
} 

const deleteFile = (fileName) => {
    return new Promise((resolve, reject) => {
        if (!fileName) {
            console.log("No file name provided, skipping deletion");
            return resolve(); // No file to delete, so resolve the promise
        }

        const fullImagePath = path.join(__dirname, '..', 'uploads', fileName);

        // Check if the file exists
        fs.exists(fullImagePath, (exists) => {
            if (!exists) {
                console.log('File does not exist: ', fullImagePath);
                return resolve(); // File doesn't exist, resolve the promise
            }

            // Proceed to delete the file
            fs.unlink(fullImagePath, (unlinkErr) => {
                if (unlinkErr) {
                    console.log('Error deleting file: ', fullImagePath, unlinkErr);
                    return reject(unlinkErr); // Reject the promise if deletion fails
                } else {
                    console.log('File deleted successfully: ', fullImagePath);
                    return resolve(); // Resolve the promise if the file is deleted
                }
            });
        });
    });
};


module.exports = {
    getFileNameFromUrl,
    deleteFile
}